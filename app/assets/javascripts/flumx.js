;
App = {};
/**
 * Minimum flux implementation
 */
var dispatcher = {
    /**
     * Store all listener
     */
    _listeners: [],
    /**
     * @param action to be attached
     * @param callback to execute
     */
    attach: function (action, callback, params) {
        if (!App.Dispatcher._listeners[action]) {
            // create callback in list of events
            App.Dispatcher._listeners[action] = {};
        }
        // save dispatch id to be deleted so we can delete it later
        var dispatchId = Date.now();
        App.Dispatcher._listeners[action][dispatchId] = callback;
        callback.__dispatecherID__ = dispatchId;
    },
    /**
     *
     */
    detach: function (action, callback) {
        if (callback.__dispatecherID__) {
            delete App.Dispatcher._listeners[action][callback.__dispatecherID__];
        }
        // remove
        delete callback.__dispatecherID__;
    },
    /**
     * @param {Object} action to be attached
     * @param {Object} data event source
     * @param {Object} event to execute
     */
    dispatch: function (action, data, event) {
        // local notification
        // lookup , when you send notification from current interface
        if (App.Dispatcher._listeners[action]) {
            App.Dispatcher._dispatchToListener(action, data, event)
        }
    },
    /**
     *
     * @private
     */
    _dispatchToListener: function (action, data, eventSource) {
        var listeners = App.Dispatcher._listeners[action];
        for (var entry in listeners) {
            listeners[entry](data, eventSource);
        }
    },
    /**
     * Future usage
     */
    notifyAll: function (notification) {
        // server notification
        var actionName = (notification || {}).action ;
        var data = notification.data ;
        if (actionName  &&  App.Dispatcher._listeners[actionName]) {
            App.Dispatcher._dispatchToListener(actionName, data);
        }
    }
};
App.Dispatcher = dispatcher;
App.Dispatcher.removeListener = dispatcher.detach;
/**
 * App routes
 */
App.Stores = {
    /**
     *
     * @param options
     */
    loadData: function (options) {
        $.ajax({
            type: 'GET',
            url: App.Helpers.formatApiUrl(options.url, options.params || {}),
            dataType: 'json',
            data: options.query || {},
            success: function (data) {
                App.Dispatcher.dispatch(options.action || options.url, data);
            }.bind(this),
            error: function (xhr, status, err) {
                console.error(options.action || options.url, status, err.toString());
            }.bind(this)
        });
    },
    /**
     *
     * @param options
     * options {
     *            url => endpoint
     *            params => url params (query ....)
     *            data => post form data
     *            action => callback event action
     *            event => data source to be dispatched onresponse to success
     *
     * }
     */
    post: function (options) {
        $.ajax({
            type: 'POST',
            url: App.Helpers.formatApiUrl(options.url, options.params || {}),
            data: options.data || {},
            success: function (data) {
                App.Dispatcher.dispatch(options.action || options.url, data, options.event || {});
            }.bind(this),
            error: function (xhr, status, err) {
                console.error(options.action || options.url, status, err.toString());
            }.bind(this)
        });
    }
};
// alias
App.Stores.get = App.Stores.loadData;

/**
 *
 * @type {string}
 */
var baseApiUrl = "/api/v1/";
/**
 * Minimum
 */
App.Helpers = {
    /**
     *
     */
    querify: function (queryObject) {
        var query = '';
        for (var key in queryObject) {
            query += key + '=' + queryObject[key];
            query += '&'
        }
        return query;
    },
    /**
     * Format an url given a key, value object
     * foo/:bar , { bar : "alex" } will be transformed to foo/alex
     * queryObject , { bar : "alex" } will be transformed to foo/alex
     */
    formatApiUrl: function (url, data, queryObject) {
        for (var key in data) {
            url = url.replace(':' + key, data[key]);
        }
        return url + (queryObject ? '?' + App.Helpers.querify(queryObject) : '');
    },
    /**
     * Format an url given a key, value object
     * foo/:bar , { bar : "alex" } will be transformed to foo/alex
     * queryObject , { bar : "alex", 'ok' : 'fine } will be transformed to ?foo=alex&ok=fine
     */
    getAbsoluteUrl: function (url, data, queryObject) {
        return App.Helpers.formatApiUrl(url, data, queryObject).replace(baseApiUrl, '/');
    },

    /**
     * Format an url given a key, value object
     * foo/:bar , { bar : "alex" } will be transformed to foo/alex
     */
    getMediaUrl: function (url, data) {
        return App.Constants.MEDIA_URL + App.Helpers.getAbsoluteUrl(url, data);
    }
};
/**
 * All dashboard js routes
 * @type {{info: string}}
 */
App.DashboradRoutes = {
    stats: '/dashboard/ajax/stats',
    galleryList: '/dashboard/gallery',
    collections: '/dashboard/collections',
    collectionsItemAdd : '/dashboard/collections/:id/add-products',
    collectionsItemRemove : '/dashboard/collections/:id/remove-products'
};
/**
 *
 */
var routes = {
    categories: 'categories',
    geoAddress: 'geo/address',
    geoSearch: 'geo/search',
    geoMine: 'geo/mine',
    brands: 'brands',
    showBrand: 'brands/:id',
    brandInfo: 'brands/:id/info',
    brandFollowers: 'brands/:id/followers',
    brandProducts: 'brands/:id/products',
    brandStores: 'brands/:id/stores',
    followBrand: 'brands/:id/follow',
    unFollowBrand: 'brands/:id/unfollow',
    // reviews

    brandReviews: 'brands/:id/reviews',

    products: 'products',
    productOfDay: 'products/product-of-day',
    wishProduct: 'products/:id/wish',
    unWishProduct: 'products/:id/unwish',
    voteProduct: 'products/:id/vote',
    unVoteProduct: 'products/:id/unvote',
    showProduct: 'products/:id/',
    notifyProduct: 'products/:id/notify',
    productWishers: 'products/:id/wishers',
    productStores: 'products/:id/stores',
    productReviews: 'products/:id/reviews',
    productCoupons: 'products/:id/coupons',
    shareProduct: 'products/:id/share',
    search: 'search',
    userProfile: 'users/:id',
    userBrands: 'users/:id/brands',
    userFollowers: 'users/:id/followers',
    userFollowing: 'users/:id/following',
    userWishes: 'users/:id/wishes'
};
/**
 *
 * @type {{}}
 */
App.Routes = {};
/**
 *
 */
for (var key in routes) {
    App.Routes[key] = baseApiUrl + routes[key];
}
App.Configuration = {
    MAP_TILES_URL: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
};

// error login
$(document).ready(function () {
    // listen to scroll
    $(window).on('scroll', function (){
        App.Dispatcher.dispatch(App.Actions.WINDOW_SCROLL, window.scrollY);
    });
    $(document).ajaxError(function (event, xhr, settings) {
        try {
            var response = xhr.responseJSON || JSON.parse(xhr.responseText);
            if (xhr.status === 401 && (response.action === App.Constants.LOGIN_ACTION)) {
                openLoginModal();
            }
        }
        catch (e) {

        }
    });
    /**
     *
     */
    $('#open_login_modal').click(function () {
        openLoginModal();
    });
    /**
     *
     */
    var openLoginModal = function () {
        $('#login_modal').modal('show');
        $('#register_modal').modal('hide');
    };
    /**
     *
     */
    $('#open_registration_modal').click(function () {
        $('#register_modal').modal('show');
        $('#login_modal').modal('hide');
    });
});

