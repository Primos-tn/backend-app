
/**
 * Minimum
 */
App.Helpers = {
    /**
     *
     * @param map
     * @returns {{map: {center: *}}}
     */
    getMapQuery : function (map) {
        return {
            map : {
                center : map.getCenter()
            }
        }
    },
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
     *
     * @param entry
     * @returns {*}
     * @private
     */
    parsePosition : function (entry){
        var position = entry.position || entry;
        if (position.latitude) {
            position = [position.latitude, position.longitude]
        }
        if (position.lat){
            position = [position.lat, position.lng]
        }
        return position;
    },
    //
    getTomorrow: function () {
        var tomorrow = new Date();
        tomorrow.setTime(tomorrow.getTime() + 60 * 60 * 24 * 1000);
        tomorrow.setHours(0);
        tomorrow.setMinutes(0);
        tomorrow.setSeconds(0);
        return tomorrow ;
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