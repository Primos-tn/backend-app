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
        return {items: [], serverLoadingDone: false};
    },
    /**
     *
     */
    loadDataFromServer: function () {
        App.Stores.loadData({
            url: App.Routes.products,
            action: this.actions.list,
            query: {
                brands: this.props.brand
            }
        });
    },

    /**
     *
     */
    componentDidMount: function () {
        //
        App.Dispatcher.attach(this.actions.list, this.onDataChange);
        App.Dispatcher.attach(App.Actions.FILTER_CHANGED, this.filterChanged);
        this.loadDataFromServer();

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
    filterChanged  (state){
        alert('listen');
        console.log(state);
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
        var items;
        //
        if (this.state.items.length) {
            items = [];
            var i = 0;
            this.state.items.forEach(function (item, index) {
                items.push(<ProductsListItem item={item} index={i} key={index + i++}/>);
            }.bind(this));

        }
        else {
            items = this.state.serverLoadingDone ? <EmptyProductsList/> : <Loading/>;
        }

        return (
            <div>
                <div className="ProductCardLisContainer">
                    {items}
                </div>
            </div>
        );
    }
});
