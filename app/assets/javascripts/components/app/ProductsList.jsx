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
        return {items: [], filter: {}, page: 0, isFetchingItems: false, maxItems: 10, noMoreItems: false};
    },
    /**
     *
     */
    getServerItems: function () {
        this.setState({isFetchingItems: true});
        // get query
        let query = $.extend({}, {
            brands: this.props.brand,
            page: this.state.page,
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
    onWindowScrolled: function (value) {
        let $container = $(ReactDOM.findDOMNode(this));
        if (!this.state.noMoreItems && !this.state.isFetchingItems &&
            $container.position().top - value < 100) {
            this.setState({page: this.state.page + 1, isFetchingItems: true});
        }

    },
    /**
     *
     */
    onFilterChanged  (filter){
        // reinitialize filter
        this.setState({filter: filter, page: 0, items: []}, () => {
            this.getServerItems();
        });

    },
    /**
     *
     */
    onDataChange: function (result) {
        let products = result.products;
        let newState = {isFetchingItems: false};
        // there's more
        if (products.length) {
            // update items
            newState['items'] = this.state.items.concat(products)
        }
        this.setState(newState);
        // check if there is more results
        if (products.length < this.state.maxItems) {
            this.setState({noMoreItems: true});
        }
        else {
            this.setState({noMoreItems: false});
        }
    },
    /**
     *
     */
    render: function () {
        var items;
        var bottomLoading = this.state.isFetchingItems ? <Loading/> : "";
        //
        if (this.state.items.length) {
            items = [];
            var i = 0;
            this.state.items.forEach(function (item, index) {
                items.push(<ProductsListItem item={item} index={i} key={index + i++}/>);
            }.bind(this));

        }
        else {
            items = this.state.isFetchingItems ? <Loading/> : <EmptyProductsList/>;
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
