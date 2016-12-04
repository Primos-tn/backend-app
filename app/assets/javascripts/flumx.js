;
App= {};
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
    attach: function (action, callback) {
        if (!App.Dispatcher._listeners[action]) {
            // create callback in list of events
            App.Dispatcher._listeners[action] = {};
        }
        // save dispatch id to be deleted in removeListener
        var dispatchId = Date.now();
        App.Dispatcher._listeners[action][dispatchId] = callback;
        callback.__dispatecherID__ = dispatchId;
    },
    /**
     *
     */
    detach : function (action, callback) {
        if (callback.__dispatecherID__){
            delete App.Dispatcher._listeners[action][callback.__dispatecherID__] ;
        }
        // remove
        delete callback.__dispatecherID__ ;
    },
    /**
     * @param {Object} action to be attached
     * @param {Object} data event source
     * @param {Object} event to execute
     */
    dispatch: function (action, data, event) {
        if (App.Dispatcher._listeners[action]) {
            var listeners = App.Dispatcher._listeners[action];
            for (var entry in listeners) {
                listeners[entry](data, event);
            }
        }
    }
};
App.Dispatcher = dispatcher ;
App.Dispatcher.removeListener = dispatcher.detach ;
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
            data : options.query,
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
     */
    post: function (options) {
        $.ajax({
            type: 'POST',
            url: options.url,
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
    querify : function (queryObject){
        var query = '';
        for (var key in data) {
            if (data[key]){
                query += key + '=' + data[key];
            }
        }
        return query;
    },
    /**
     * Format an url given a key, value object
     * foo/:bar , { bar : "alex" } will be transformed to foo/alex
     * query , { bar : "alex" } will be transformed to foo/alex
     */
    formatApiUrl: function (url, data, query) {
        for (var key in data) {
            url = url.replace(':' + key, data[key]);
        }
        return url ;
    },
    /**
     * Format an url given a key, value object
     * foo/:bar , { bar : "alex" } will be transformed to foo/alex
     */
    getAbsoluteUrl : function (url, data) {
        return App.Helpers.formatApiUrl(url, data).replace(baseApiUrl, '/');
    },

    /**
     * Format an url given a key, value object
     * foo/:bar , { bar : "alex" } will be transformed to foo/alex
     */
    getMediaUrl : function (url, data) {
        return '/images/' + App.Helpers.getAbsoluteUrl(url, data);
    }
};
/**
 *
 */
var routes = {
    brands: 'brands',
    followBrand: 'brands/:id/follow',
    unFollowBrand: 'brands/:id/unfollow',
    brand: 'brands/:id',
    brandInfo: 'brands/:id/info',
    brandFollowers: 'brands/:id/followers',
    brandProducts: 'brands/:id/products',
    brandReviews: 'brands/:id/reviews',
    brandStores: 'brands/:id/stores',
    products: 'products',
    productOfDay: 'products/product-of-day',
    wishProduct: 'products/:id/wish',
    unWishProduct: 'products/:id/unwish',
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
 * @type {{}}
 */
App.Actions = {
    SEARCH : 'SEARCH',
    NOTIFICATION : 'NOTIFICATION'
};
/**
 *
 * @type {{}}
 */
App.Constants = {
    AUTO_COMPLETE : 'AUTOCOMPLETE',
    MEDIA_URL : '/images',
    LOGIN_ACTION : 'LOGIN',
    END_DAY : 'END_DAY'
};
/**
 *
 */
for (var key in routes) {
    App.Routes[key] = baseApiUrl + routes[key];
}
// error login
$(document).ready(function (){
    $(document).ajaxError(function(event, xhr, settings) {
        try {
            var response = xhr.responseJSON  || JSON.parse(xhr.responseText);
            if (xhr.status === 401 && (response.action === App.Constants.LOGIN_ACTION)){
                openLoginModal();
            }
        }
        catch (e){

        }
    });
    /**
     *
     */
    $('#open_login_modal').click (function (){
        openLoginModal();
    });
    /**
     *
     */
    var openLoginModal = function (){
        $('#login_modal').modal('show');
        $('#register_modal').modal('hide');
    };
    /**
     *
     */
    $('#open_registration_modal').click (function(){
        $('#register_modal').modal('show');
        $('#login_modal').modal('hide');
    });
});

