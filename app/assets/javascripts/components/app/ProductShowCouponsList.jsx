var ProductShowCouponsListItem = React.createClass({
    shareCoupon: function () {
        alert("coupon");
    },
    /**
     *
     */
    render: function () {
        return (
            <div className="ProductCouponsList__Item">
                <div>
                    <img src={this.props.item.image_qr_code}/>
                    <button className="AppButton" onClick={this.shareCoupon}>{i18n.Share}</button>
                </div>
            </div>
        )

    }
});
var ProductShowCouponsList = React.createClass({
    /**
     *
     */
    actions: {
        list: "PRODUCT_COUPONS_LIST"
    },
    /**
     *
     */
    loadDataFromServer: function () {
        App.Stores.loadData({
            url: App.Routes.productCoupons,
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
        this.setState({items: response.result.coupons, serverLoadingDone: true});
    },
    /**
     *
     */
    render: function () {
        var items = [];
        //
        if (this.state.items.length) {
            //
            this.state.items.forEach(function (entry, index) {
                if (entry.image_qr_code){
                    items.push(<ProductShowCouponsListItem item={entry} key={index}/>);
                }
            });

            /*
             items = this.state.items.map(function (item, index) {
             return (<ProductCouponListItem item={item} key={index}/>);
             }.bind(this));*/
        }
        else {
            items = this.state.serverLoadingDone ? '0 items ' : "Loading ....";
        }

        return (
            <div className="ProductCouponsList">
                {items}
            </div>
        )
    }
});