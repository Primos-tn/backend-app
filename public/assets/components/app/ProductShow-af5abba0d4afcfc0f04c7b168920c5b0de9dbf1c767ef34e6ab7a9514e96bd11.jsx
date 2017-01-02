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
        return {item: {}, serverLoadingDone: false, baseImageUrl: null};
    },
    /**
     *
     */
    onDataChange: function (result) {
        this.setState({serverLoadingDone: true, item: result});
    },

    /**
     * Callback to change current image
     */
    onImageThumbnailClicked: function (image, e) {
        e.preventDefault();
        this.setState({baseImageUrl: App.Constants.MEDIA_URL + image.url});
    },
    /**
     *
     */
    render: function () {
        var activeTab = this.props.activeTab;
        var item = this.state.item;
        var baseImageUrl = this.state.baseImageUrl;
        if (!baseImageUrl && item.pictures && item.pictures.length) {
            baseImageUrl = App.Constants.MEDIA_URL + item.pictures[0].url;
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
        return (
            <div className="col-lg-12">
                 <div className="ProductDetails col-lg-12">
                    <div className="ProductDetails__Cover">

                        <img className="ProductDetails__BaseImage" src={baseImageUrl}/>
                        <span className="ProductDetails__Name">
                            {item.name || ''}
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
                                <i className="fa fa-circle"></i> Stores
                            </a>
                        </li>

                        <li className={activeTab == COUPON_TAB ? ACTIVE_CLASS : ''}>
                            <a href={App.Helpers.getAbsoluteUrl(App.Routes.productCoupons, { id : this.props.id})}>
                                <i className="fa fa-circle"></i> Coupons
                            </a>
                        </li>
                    </ul>
                    {container}
                </div>
            </div>
        );
    }
});
