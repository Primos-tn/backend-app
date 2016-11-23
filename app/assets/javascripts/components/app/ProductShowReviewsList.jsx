var ProductShowReviewsListItem = React.createClass({
    /**
     *
     */
    render: function () {
        return (
            <div className="ProductCard__Wisher">
                <img src="https://s-media-cache-ak0.pinimg.com/avatars/tatianamamaeva_1382583329_30.jpg"/>
            </div>
        )

    }
});
var ProductShowReviewsList = React.createClass({

    actions: {
        list: "PRODUCT_WISHERS_LIST"
    },
    /**
     *
     */
    loadDataFromServer: function () {
        App.Stores.loadData({
            url: App.Routes.productReviews,
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
        this.setState({items: response.result.reviews, serverLoadingDone: true});
    },
    /**
     *
     */
    render: function () {
        var items;
        //
        if (this.state.items.length) {
            items = this.state.items.map(function (item, index) {
                return (<ProductShowReviewsListItem item={item} key={index}/>);
            }.bind(this));
        }
        else {
            items = this.state.serverLoadingDone ? '0 items ' : "Loading ....";
        }

        return (
            <div className="ProductCard__WishersList">
                {items}
            </div>
        )
    }
});