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
    getInitialState: function () {
        return {item: {}, serverLoadingDone: false, baseImageUrl: null, isVoted: false, votesCount: 0};
    },
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
        App.Dispatcher.attach(App.Actions.PRODUCT_VOTE, this.onVotedListener);
        App.Dispatcher.attach(this.actions.show, this.onDataChanged);
        this.loadDataFromServer();
    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(App.Actions.PRODUCT_VOTE, this.onVotedListener);
        App.Dispatcher.detach(this.actions.list, this.onDataChanged);
    },
    /**
     *
     */
    onDataChanged: function (result) {
        this.setState({
            serverLoadingDone: true,
            item: result,
            isVoted: result.is_voted,
            votesCount: result.votes_count
        });
    },
    /**
     * Callback to change current image
     */
    onImageThumbnailClicked: function (image, e) {
        e.preventDefault();
        this.setState({baseImageUrl: App.Constants.MEDIA_URL + image.file.url});
    },
    /**
     *
     * @param payload
     */
    onVotedListener: function (payload) {
        let content = payload.content ;
        if (content.action && content.data && content.data.product_id == this.state.item.id) {
            let increment = 0;
            let isVoted;
            if (content.action == App.Actions.PRODUCT_VOTE_UP) {
                increment = 1;
                isVoted = true;
            }
            else if (content.action == App.Actions.PRODUCT_VOTE_DOWN) {
                increment = -1;
                isVoted = false;
            }
            if (increment !== 0 && isVoted != this.state.isVoted) {
                var votesCount = this.state.votesCount + increment;
                this.setState({isVoted: isVoted, votesCount: votesCount});
            }
        }
    },
    /**
     *
     * @param isVoted
     * @param id
     * @private
     */
    _getVoteActionUrl (isVoted, id){
        var url = isVoted ? App.Routes.unVoteProduct : App.Routes.voteProduct;
        return App.Helpers.formatApiUrl(url, {id: id});
    },
    /**
     *
     * @param e
     * @private
     */
    _voteAction: function (e) {
        e.preventDefault();
        let id = this.state.item.id;
        App.Stores.post({
            url: this._getVoteActionUrl(this.state.isVoted, id),
            action: App.Actions.PRODUCT_VOTE,
            event: {
                id: id
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
            case REVIEWS_TAB :
            default:
                container = <ProductShowReviewsList id={this.props.id}/>;
        }
        let brand = null;
        if (item.brand) {
            brand = (<a className="ProductCard__BrandImageContainer"
                        href={App.Helpers.getAbsoluteUrl(App.Routes.showBrand, {id : item.brand.id})}>
                <img
                    src={App.Helpers.getMediaUrl(item.brand.picture.thumb.url)}
                    alt={item.brand.name}/>
            </a>);
        }
        let voteButtonClassName = this.state.isVoted ? "ti-arrow-down" : "ti-arrow-up";
        return (
            <div className="col-lg-12">
                <div className="ProductDetails col-lg-12">
                    <div className="ProductDetails__Cover">
                        <div className="ProductDetails__Menu">
                            <div className="btn-group">
                                <button type="button" onClick={this._shareAction} className="btn"><span
                                    className="ti-signal"></span></button>
                                <button type="button" onClick={this._voteAction} className="btn"><span
                                    className={voteButtonClassName}></span></button>
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
                        <div className="pull-right ProductCard__VotesCount">
                            {this.state.votesCount}
                        </div>
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