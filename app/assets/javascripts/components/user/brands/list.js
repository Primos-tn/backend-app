"use strict";
var BrandsList = function () {

    // Get html template
    var template = $('template:first').html();
    // Get the template function
    this.compiledTemplate = _.template(template);
    // get list item
    this.$list = $('#list');

};
/**
 *
 * @type {{loadData: ProductList.loadData}}
 */
BrandsList.prototype = {
    /**
     *
     */
    init: function () {

    },
    /**
     *
     */
    loadData: function (query) {
        // Get products query
        query = query || $.extend({}, {}, App.Helpers.getUserPosition(), App.Helpers.getUrlParameters(['category']));
        App.Stores.loadData({
            url: App.Routes.brands,
            query: query
        }).then(function (data) {
            console.log(data);
            _.each(data.brands, function (item) {
                this.$list.append($(this.compiledTemplate(item)))
            }.bind(this));
            $('.brand-image').on('error', function () {
                $(this).attr('src', App.Helpers.getDefaultCoverPicture());
            });
        }.bind(this));


    }
};
