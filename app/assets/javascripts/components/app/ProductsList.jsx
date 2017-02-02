/**
 *
 */
var ProductsList = React.createClass({
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
        return {items: [], filter: {}, page : 0, needMore : true};
    },
    /**
     *
     */
    getServerItems: function () {
        // get query
        let query = $.extend({
            brands: this.props.brand,
            page : this.state.page
        }, this.state.filter);
        //
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
        App.Dispatcher.attach(this.actions.list, this.onDataChange);
        App.Dispatcher.attach(App.Actions.WINDOW_SCROLL, this.onWindowScrolled);
        App.Dispatcher.attach(App.Actions.FILTER_CHANGED, this.onFilterChanged);
        this.getServerItems();

    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(this.actions.list, this.onDataChange);
        App.Dispatcher.detach(App.actions.WINDOW_SCROLL, this.onWindowScrolled);
        App.Dispatcher.detach(App.Actions.FILTER_CHANGED, this.onFilterChanged);
    },

    /**
     *
     */
    onWindowScrolled : function (value){
        let $container = $(ReactDOM.findDOMNode(this)) ;
        if (!this.state.needMore && $container.position().top - value < 100 ){
            this.setState({page : this.state.page + 1, needMore : true});
        }

    },
    /**
     *
     */
    onFilterChanged  (filter){
        this.setState({filter: filter, page : 0});
        this.getServerItems();
    },
    /**
     *
     */
    onDataChange: function (result) {
        this.setState({items: this.state.items.push(result.products), needMore: false}, function () {

        });
    },
    /**
     *
     */
    render: function () {
        var items;
        var bottomLoading = this.state.needMore ? <Loading/> : "" ;
        //
        if (this.state.items.length) {
            items = [];
            var i = 0;
            this.state.items.forEach(function (item, index) {
                items.push(<ProductsListItem item={item} index={i} key={index + i++}/>);
            }.bind(this));

        }
        else {
            items = this.state.needMore ? <Loading/> : <EmptyProductsList/>  ;
            bottomLoading = "";
        }

        return (
            <div>
                <div className="ProductCardLisContainer">
                    {items}
                    {bottomLoading}
                </div>
            </div>
        );
    }
});
