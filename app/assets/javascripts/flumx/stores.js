/**
 * App routes
 */
App.Stores = {
    /**
     *
     * @param options
     */
    loadData: function (options) {
        var $defer = $.Deferred();
        $.ajax({
            type: 'GET',
            url: App.Helpers.formatApiUrl(options.url, options.params || {}),
            dataType: 'json',
            data: options.query || {},
            success: function (data) {
                $defer.resolve(data);
                App.Dispatcher.dispatch(options.action || options.url, data);
            }.bind(this),
            error: function (xhr, status, err) {
                $defer.reject(err);
                console.error(options.action || options.url, status, err.toString());
            }.bind(this)
        });
        return $defer;
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
        var $defer = $.Deferred();
        $.ajax({
            type: 'POST',
            url: App.Helpers.formatApiUrl(options.url, options.params || {}),
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
            },
            data: options.data || {},
            success: function (data) {
                $defer.resolve(data);
                App.Dispatcher.dispatch(options.action || options.url, data, options.event || {});
            }.bind(this),
            error: function (xhr, status, err) {
                $defer.reject(err);
                console.error(options.action || options.url, status, err.toString());
            }.bind(this)
        });
        return $defer;
    }
};
// alias
App.Stores.get = App.Stores.loadData;