//= require jquery
//= require jquery_ujs
//= require_tree  ./vendor
//= require react
//= require react_ujs
//= require websocket
//= require  ./flumx/index
//= require ./modules/dropzone
//= require ./modules/bootstrap-notify
//= require_tree ./components/dashboard
//= require_self
// body
$(document).ready(function (){
    $('.main-panel').on('scroll', function (){
        console.log('#################"');
    });
    // get all flash message
    $('.flash').each(function (){
        var $this = $(this);
        $.notify({
            icon: 'ti-gift',
            message: $this.data('text')

        },{
            type: 'danger',
            timer: 2000
        });
    })
});