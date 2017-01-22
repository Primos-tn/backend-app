//
var DashboardRTConnectorIndicator = React.createClass({
    /**
     *
     * @returns {{connected: boolean}}
     */
    getInitialState: function () {
        return {
            connected: false
        }
    },
    /**
     */
    componentDidMount: function () {
        App.Dispatcher.attach(App.Actions.WS_CONNECTION_LOST, this.onDisconnect);
        App.Dispatcher.attach(App.Actions.WS_CONNECTION_ESTABLISHED, this.onConnect);

    },
    /**
     */
    componentWillUnmount: function () {
        App.Dispatcher.removeListener(App.Actions.WS_CONNECTION_LOST, this.onDisconnect);
        App.Dispatcher.removeListener(App.Actions.WS_CONNECTION_ESTABLISHED, this.onConnect);
    },
    /**
     *
     * @private
     */
    onDisconnect: function () {
        this.setState({connected: false});
    },
    /**
     *
     * @private
     */
    onConnect: function () {
        this.setState({connected: true});
    },
    /**
     *
     */
    render: function () {
        let className = "DashboardRT__Indicator "  +  (this.state.connected ? 'DashboardRT__Indicator--on' : 'DashboardRT__Indicator--off') ;
        return (<div className={className} title={i18n['WS connection status']}> </div>)
    },
});
