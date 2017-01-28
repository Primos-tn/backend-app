/**
 *
 */
var MapView = React.createClass({
    /**
     *
     */
    actions: {
        list: "PRODUCTS_LIST"
    },
    /**
     *
     */
    getInitialState: function () {
        return {items: [], serverLoadingDone: false, filter: {}};
    },
    /**
     *
     */
    getServerItems: function () {
        // get query
        let query = $.extend({
            brands: this.props.brand
        }, this.state.filter);

        App.Stores.loadData({
            url: App.Routes.products,
            action: this.actions.list,
            query: query
        });
    },

    /**
     *
     */
    componentDidMount: function () {
        $(window).on('scroll', function () {
            console.log('#################"');
        });
        App.Dispatcher.attach(this.actions.list, this.onDataChange);
        App.Dispatcher.attach(App.Actions.FILTER_CHANGED, this.filterChanged);
        this.getServerItems();


    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(this.actions.list, this.onDataChange);
        App.Dispatcher.detach(App.actions.FILTER_CHANGED, this.filterChanged);
    },
    /**
     *
     */
    onMapAreaChanged  (filter){
    },
    /**
     *
     */
    onDataChange: function (result) {
        this.setState({items: result.products, serverLoadingDone: true}, function () {

        });
    },
    /**
     *
     */
    render: function () {
        return (<div>
            <Map onMapAreaChanged={this.onMapAreaChanged}></Map>

        </div>)
    }
});
