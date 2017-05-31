"use strict";
/**
 *
 * @param brandId
 * @constructor
 */
var BrandReviewsForm = function (brandId) {
    this.$el = null;
    this.brandId = brandId;
    this.init();
    window.brandReviewForm = this;
};
/**
 *
 * @type {{init: BrandReviewsForm.init, edit: BrandReviewsForm.edit, _prepareMine: BrandReviewsForm._prepareMine}}
 */
BrandReviewsForm.prototype = {
    /**
     *
     */
    init: function () {
        this.$el = $('#brand_review_form:first');
        this.$form = this.$el.find('form');
        this.$el.find('input[type="submit"]').click(this.edit.bind(this));
        this.$form.submit(function () {
            return false;
        });
    },
    /**
     *
     */
    setMine: function (review) {
        if (review){
            this.$el.find('#my_review_body').val(review.body);
            this.$el.find('#eval').val(review.eval);
        }

    },
    /**
     *
     */
    edit: function () {
        App.Stores.post({
            url: App.Routes.brandReviews,
            action: App.Actions.BRAND_EDIT_REVIEW,
            params: {
                id: this.brandId
            },
            data: {
                review: {
                    eval: this.$el.find('#eval').val(),
                    body: this.$el.find('#my_review_body').val()
                }
            }
        }).done(function () {

        }).fail(function () {

        });
    }
};