//
var DashboardNotifier = React.createClass({
    /**
     *
     */
    propTypes: {
        count: React.PropTypes.number,
        items: React.PropTypes.array
    },
    /**
     *
     * @returns {{count: number, items: Array}}
     */
    getInitialState: function () {
        return {
            count: 1
        }
    },
    /**
     */
    componentDidMount: function () {
        App.Dispatcher.attach(App.Actions.ADMIN_NOTIFICATION, this._onNotificationArrived);

    },
    /**
     */
    componentWillUnmount: function () {
        App.Dispatcher.removeListener(App.Actions.ADMIN_NOTIFICATION, this._onNotificationArrived);
    },
    /**
     *
     * @private
     */
    _onNotificationArrived: function (data) {
        this.setState({count: data.count + this.state.count});
    },
    /**
     *
     */
    render: function () {
        var components = null ;
        if (this.state.count){
            components = (<p className="notification"> {this.state.count} </p>);
        }
        /**
         *
         */
        return (
            <a href={this.props.link_to}>
                <i className="ti-bell"/> {components}
            </a>
        );
    },
});
