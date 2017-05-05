//= require ./icheck
//= require ./infobox
//= require ./main
//= require_self

$(document).ready(function () {
    (new BrandsList()).loadData();
});