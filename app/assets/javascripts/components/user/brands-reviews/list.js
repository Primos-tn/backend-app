"use strict";
/**
 *
 * @param brandId
 * @constructor
 */
var BrandReviewsList = function (brandId) {
    this.init({brandId: brandId});
};
/**
 *
 * @type {{init: BrandReviewsList.init, edit: BrandReviewsList.edit, loadData: BrandReviewsList.loadData}}
 */
BrandReviewsList.prototype = {
    /**
     *
     * @param options
     */
    init: function (options) {
        this.brandId =  options.brandId;
        // Get html template
        var template = $('template:first').html();
        // Get the template function
        this.compiledTemplate = _.template(template);
        // get list item
        this.$list = $('#brand_reviews_list');
    },
    /**
     *
     */
    loadData: function () {
        App.Stores.loadData({
            url: App.Routes.brandReviews,
            params : {id: this.brandId},
            query:  {}
        }).then(function (data) {
            _.each(data.reviews, function (item) {
                this.$list.append($(this.compiledTemplate(item)))
            }.bind(this));
            brandReviewForm.setMine(data.mine);
        }.bind(this));
    }
};
