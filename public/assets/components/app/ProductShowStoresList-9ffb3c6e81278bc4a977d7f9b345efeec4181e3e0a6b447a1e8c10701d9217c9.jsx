var ProductShowStoresListItem = React.createClass({
    shareCoupon : function (){
        alert ("coupon");
    },
    /**
     *
     */
    render: function () {
        return (
            <div className="ProductCouponsList__Item">
                 <div>
                    <Button onClick={this.shareCoupon}/>
                </div>
            </div>
        )

    }
});
var ProductShowStoresList = React.createClass({
    /**
     *
     */
    actions: {
        list: "PRODUCT_STORES_LIST"
    },
    /**
     *
     */
    loadDataFromServer: function () {
        App.Stores.loadData({
            url: App.Routes.productStores,
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
        this.setState({items: response.result.stores, serverLoadingDone: true});
    },
    /**
     *
     */
    render: function () {

        return (
            <div className="ProductCouponsList">
                <Map positions={[[51.5, -0.09], [52.5, -0.2]]}/>
            </div>
        )
    }
});