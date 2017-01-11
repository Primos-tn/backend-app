/**
 *
 */

const ACTIVE_CLASS = "active";


const WISHERS_TAB = "wishers";
const STORES_TAB = "stores";
const REVIEWS_TAB = "reviews";
const COUPON_TAB = "coupons";
/**
 *
 */
var ProductShow = React.createClass({
    /**
     *
     */
    actions: {
        show: "SHOW_PRODUCT"
    },
    /**
     *
     */
    loadDataFromServer: function () {
        App.Stores.loadData({
            url: App.Routes.showProduct,
            action: this.actions.show,
            params: {id: this.props.id}
        });
    },

    /**
     *
     */
    componentDidMount: function () {
        App.Dispatcher.attach(this.actions.show, this.onDataChange);
        this.loadDataFromServer();
    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(this.actions.list, this.onDataChange);
    },
    /**
     *
     */
    getInitialState: function () {
        return {item: { }, serverLoadingDone: false, baseImageUrl: null, isWishing: false};
    },
    /**
     *
     */
    onDataChange: function (result) {
        this.setState({serverLoadingDone: true, item: result, isWishing : result.is_wishing});
    },

    /**
     * Callback to change current image
     */
    onImageThumbnailClicked: function (image, e) {
        e.preventDefault();
        this.setState({baseImageUrl: App.Constants.MEDIA_URL + image.file.url});
    },
    /**
     * Share action
     */
    _shareAction (e) {
        e.preventDefault();
        App.Stores.get({
            url: App.Helpers.formatApiUrl(App.Routes.shareProduct, {id: this.state.item.id})
        });
    },

    /**
     *
     * @param isWishing
     * @private
     */
    _getFollowActionUrl (isWishing){
        var url = isWishing ? App.Routes.unWishProduct : App.Routes.wishProduct;
        return App.Helpers.formatApiUrl(url, {id: this.state.item.id});
    },
    /**
     * Wish action
     */
    _wishAction: function (e) {
        e.preventDefault();
        App.Stores.post({
            url: this._getFollowActionUrl(this.state.isWishing),
            action: this.actions.wish,
            event: {
                id: this.state.item.id
            }
        });
    },
    /**
     *
     */
    render: function () {
        var activeTab = this.props.activeTab;
        var item = this.state.item;
        var baseImageUrl = this.state.baseImageUrl;
        if (!baseImageUrl && item.pictures && item.pictures.length) {
            baseImageUrl = App.Constants.MEDIA_URL + item.pictures[0].file.url;
        }
        var container = null;
        switch (activeTab) {
            case STORES_TAB :
                container = <ProductShowStoresList id={this.props.id}/>;
                break;
            case WISHERS_TAB :
                container = <ProductShowWishersList id={this.props.id}/>;
                break;
            case COUPON_TAB :
                container = <ProductShowCouponsList id={this.props.id}/>;
                break;
            case REVIEWS_TAB :
            default:
                container = <ProductShowReviewsList id={this.props.id}/>;
        }
        let brand = null;
        if (item.brand){
            brand = (<a className="ProductCard__BrandImageContainer"
                        href={App.Helpers.getAbsoluteUrl(App.Routes.brand, {id : item.brand.id})}>
                <img
                    src={App.Helpers.getMediaUrl(item.brand.picture.thumb.url)}
                    alt={item.brand.name}/>
            </a>);
        }
        return (
            <div className="col-lg-12">
                <div className="ProductDetails col-lg-12">
                    <div className="ProductDetails__Cover">
                        <div className="ProductDetails__Menu">
                            <div className="btn-group">
                                <button type="button" onClick={this._shareAction} className="btn"> <span className="ti-signal"></span></button>
                                <button type="button" onClick={this._wishAction} className="btn"> <span className="ti-heart"></span></button>
                            </div>
                        </div>

                        <img className="ProductDetails__BaseImage" src={baseImageUrl}/>

                        <span className="ProductDetails__Name">
                            {item.name || ''} by {brand}
                        </span>
                        <span className="ProductDetails__Stats">
                            <DayTimer/>
                        </span>

                        <ProductShowGallery pictures={item.pictures || [] }
                                            onImageThumbnailClicked={this.onImageThumbnailClicked}/>
                    </div>
                    <ul className="nav nav-tabs">

                        <li className={activeTab == STORES_TAB ? ACTIVE_CLASS : ''}>
                            <a href={App.Helpers.getAbsoluteUrl(App.Routes.productStores, { id : this.props.id})}>
                                <i className="ti-align-justify"></i> Info
                            </a>
                        </li>
                        <li className={activeTab == COUPON_TAB ? ACTIVE_CLASS : ''}>
                            <a href={App.Helpers.getAbsoluteUrl(App.Routes.productStores, { id : this.props.id})}>
                                <i className="ti-map"></i> Stores
                            </a>
                        </li>

                        <li className={activeTab == COUPON_TAB ? ACTIVE_CLASS : ''}>
                            <a href={App.Helpers.getAbsoluteUrl(App.Routes.productCoupons, { id : this.props.id})}>
                                <i className="ti-agenda"></i> Coupons
                            </a>
                        </li>
                    </ul>
                    {container}
                </div>
            </div>
        );
    }
});
