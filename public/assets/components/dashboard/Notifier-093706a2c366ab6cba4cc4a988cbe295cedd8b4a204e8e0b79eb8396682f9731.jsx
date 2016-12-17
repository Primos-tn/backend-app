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
            count: 0, items: [{
                text: "me SDFSDFqsdfqf"
            }, {
                text: "me sdfqsdf "
            }, {
                text: "me SDSDFQFQDFQSDFQSDFD"
            }, {
                text: "me again"
            }]
        }
    },
    /**
     */
    componentDidMount: function () {
        App.Dispatcher.attach(App.Actions.NOTIFICATION, this._OnNotificationArrived);

    },
    /**
     */
    componentWillUnmount: function () {
        App.Dispatcher.removeListener(App.Actions.NOTIFICATION, this._OnNotificationArrived);
    },
    /**
     *
     * @private
     */
    _OnNotificationArrived: function (data) {
        this.setState({count: data.count});
        this.setState({items: data.list});
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
