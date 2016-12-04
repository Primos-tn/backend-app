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
    getInitialState : function (){
        return {count : 0, items : [{
            text : "me SDFSDFqsdfqf"
        },{
            text : "me sdfqsdf "
        },{
            text : "me SDSDFQFQDFQSDFQSDFD"
        },{
            text : "me again"
        }]}
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
    _OnNotificationArrived : function (data){
        this.setState({count : data.count});
        this.setState({items : data.list});
    },
    /**
     *
     */
    render: function () {
        var items = [];
        /**
         *
         */
        this.state.items.forEach(function (entry){
            items.push(<li><a href="#">{entry.text}</a></li>)
        });
        /**
         *
         */
        return (
            //<>
            <a href="#" className="dropdown-toggle" data-toggle="dropdown">
                <i className="ti-bell"/> <p className="notification"> {this.state.count} </p>
                <p>items</p>
                <b className="caret"/>
                <ul className="dropdown-menu">
                    {items}
                </ul>
            </a>

            //</>
        );
    },
});
