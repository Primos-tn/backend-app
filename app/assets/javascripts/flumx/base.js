window.App = {};
/**
 *
 * @type {string}
 */
var baseApiUrl = "/api/v1/";
App.Configuration = {
    MAP_TILES_URL: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
};

// error login
$(document).ready(function () {
    console.log('base ready');
    // listen to scroll
    $(window).on('scroll', function () {
        App.Dispatcher.dispatch(App.Actions.WINDOW_SCROLL, window.scrollY);
    });

    $(document).ajaxError(function (event, xhr, settings) {
        try {
            var response = xhr.responseJSON || JSON.parse(xhr.responseText);
            if (xhr.status === 401 && (response.action === App.Constants.LOGIN_ACTION)) {
                openLoginModal();
            }
            else {
                if ((xhr.status === 422) && (response.code === App.Constants.MISSING_LOCATION)) {
                    App.Helpers.locate();
                }
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
    // intialize application
    App.init();
});
/**
 *
 */
App.init = function (options) {
    options = options || {};
    // set underscore template as mustache
    _.templateSettings = {
        interpolate: /\{\{(.+?)\}\}/g
    };
};

