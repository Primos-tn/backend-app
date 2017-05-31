//= require ./icheck
//= require ./infobox
//= require ./list
//= require ./map
//= require ./../brands-reviews/index
//= require_self
$(document).ready(function () {
    $('input').iCheck({
        checkboxClass: 'icheckbox_square-grey',
        radioClass: 'iradio_square-grey'
    });
    $(document).ready(function () {
        //
        var query = $.extend({}, {}, App.Helpers.getUserPosition(), App.Helpers.getUrlParameters(['category']));
        (new BrandsList()).loadData();
        new MapList({url: App.Routes.brands, query: query});
    });
});