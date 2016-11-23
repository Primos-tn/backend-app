var ProductShowCouponsListItem = React.createClass({
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
        var items;
        //
        if (this.state.items.length) {
            //
            let clone = this.state.items[0];
            items = [];
            for (let i = 0; i < 50; i++) {
                items.push(<ProductShowCouponsListItem item={clone} key={i}/>)
            }
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