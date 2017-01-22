$(document).ready(function () {
    var $wsConfig = $('#ws_config');
    var host = $wsConfig.data('host');
    var userId = $wsConfig.data('user');
    var isDashboard = $wsConfig.data('connection');
    var retry = 0;
    var wsUrl = host + '?user_id=' + userId;
    var serversocket;

    /**
     *
     */
    function createWs() {
        serversocket = new WebSocket(wsUrl, false);
        //
        serversocket.onopen = function () {
            retry = 0;
            console.log('success wss');
            App.Dispatcher.dispatch(App.Actions.WS_CONNECTION_ESTABLISHED);
        };
        // Write message on receive
        serversocket.onmessage = function (e) {
            console.log(JSON.parse(e.data));
            try {
                var notification = JSON.parse(e.data);
                //App.Dispatcher.notifyAll(notification);
                if (isDashboard) {
                    alert('will notify');
                    App.Dispatcher.dispatch(App.Actions.ADMIN_NOTIFICATION, {count: 1});
                }
            }
            catch (err) {
                console.log(err)
            }
        };

        // Write message on receive
        serversocket.onerror = function (e) {
            retry++;
            // retry connection after 1 sec
        };

        // Write message on receive
        serversocket.onclose = function (e) {
            retry++;
            App.Dispatcher.dispatch(App.Actions.WS_CONNECTION_LOST);
            setTimeout(createWs, 1000);
        };
    }
    //
    createWs();
});