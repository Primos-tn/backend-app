// app/assets/javascripts/components/article.js.jsx
var BrandsList = React.createClass({
    /**
     *
     */
    getInitialState: function () {
        return {items: [], isFetchingItems: false, page: 0, maxItems: 10, noMoreItems: true};
    },
    /**
     *
     */
    componentDidMount: function () {
        App.Dispatcher.attach(App.Actions.BRAND_LIST_FETCHING, this.onDataChange);
        App.Dispatcher.attach(App.Actions.WINDOW_SCROLL, this.onWindowScrolled);
        App.Dispatcher.attach(App.Actions.FILTER_CHANGED, this.onFilterChanged);
        this._fetchItems();
    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(App.Actions.BRAND_LIST_FETCHING, this.onDataChange);
        App.Dispatcher.detach(App.Actions.WINDOW_SCROLL, this.onWindowScrolled);
        App.Dispatcher.detach(App.Actions.FILTER_CHANGED, this.filterChanged);
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
            this._fetchItems();
        });
    },
    /**
     *
     */
    _fetchItems: function () {
        this.setState({isFetchingItems: true});
        // get query
        let query = $.extend({}, {
            brands: this.props.brand,
            page: this.state.page
        }, this.state.filter);


        App.Stores.loadData({
            url: App.Routes.brands,
            action: App.Actions.BRAND_LIST_FETCHING,
            query: query
        });
    },
    /**
     *
     */
    onDataChange: function (result) {
        let brands = result.brands;
        // there's more
        if (brands.length) {
            this.setState({
                items: this.state.items.concat(brands),
                isFetchingItems: false
            });
        }

        // check if there is more results
        if (brands.length < this.state.maxItems) {
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
            items = this.state.items.map(function (item, index) {
                return <BrandsListItem item={item} key={index}/>;
            }.bind(this));
        }
        else {
            items = this.state.isFetchingItems ? <Loading/> : <EmptyProductsList/>;
            bottomLoading = "";
        }
        return (
            <div>
                {items}
                {bottomLoading}
            </div>
        );
    }
});
