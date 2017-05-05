//= require ./icheck
//= require ./infobox
//= require ./main
//= require_self

$(function () {
    //App.Helpers.locate(function (err) {
    //if (!err) {
    console.log('ready products');
    App.init({urlParams: ['category']});
    (new ProductsList()).loadData();
    //}
    //});
});