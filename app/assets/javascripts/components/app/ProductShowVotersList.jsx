var ProductsListItemWishersListItem = React.createClass({
    /**
     *
     */
    render: function () {
        return (
            <div className="ProductWishersList__Item">
                <img src="https://s-media-cache-ak0.pinimg.com/avatars/tatianamamaeva_1382583329_30.jpg"/>
                <div>
                    <span>favorites</span> : <span>{this.props.item.products_count}</span>
                    <span>brands</span> : <span>{this.props.item.brands_count}</span>
                </div>
            </div>
        )

    }
});
var ProductsListItemWishersList = React.createClass({

    actions: {
        list: "PRODUCT_WISHERS_LIST"
    },
    /**
     *
     */
    loadDataFromServer: function () {
        App.Stores.loadData({
            url: App.Routes.productWishers,
            params: {id: this.props.id},
            action: this.actions.list
        });
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
    componentDidMount: function () {
        App.Dispatcher.attach(this.actions.list, this.onDataServerLoaded);
        this.loadDataFromServer();
    },
    /**
     *
     */
    onDataServerLoaded: function (response) {
        this.setState({items: response.result.voters, serverLoadingDone: true});
    },
    /**
     *
     */
    render: function () {
        var items;
        //
        if (this.state.items.length) {
            //
            let clone = this.state.items[0];
            items = [];
            for (let i = 0; i < 50; i++) {
                items.push(<ProductsListItemWishersListItem item={clone} key={i}/>)
            }
            /*
             items = this.state.items.map(function (item, index) {
             return (<ProductWishersListItem item={item} key={index}/>);
             }.bind(this));*/
        }
        else {
            items = this.state.serverLoadingDone ? '0 items ' : "Loading ....";
        }

        return (
            <div className="ProductWishersList">
                {items}
            </div>
        )
    }
});