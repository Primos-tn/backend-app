/**
 *
 * @private
 */
function _appendNotification(name, value) {
    var $notification = $('<div class="SideBarTabNotification"></div>').html(value);
    $('[data-tab="'+ name + '"]').find('a').prepend($notification);
}
/**
 *
 */
function _displayNotifications(data) {
    // {"business_pending_count":1,"invitations_pending_count":2,"business_accounts_count":1,"brands":0}
    _appendNotification('BusinessRequests', data.business_pending_count);
    _appendNotification('Invitations', data.invitations_pending_count);
    _appendNotification('BusinessAccounts', data.business_accounts_count);
    _appendNotification('Brands', data.brands_count);

}
/**
 * Get server info
 */
function getInfo() {
    $.get('/admin/ajax/info', _displayNotifications)
}
/**
 *
 */
AdminBaseApp = React.createClass({
    componentDidMount(){
        getInfo();
    },
    render (){
        return null;
    }
});