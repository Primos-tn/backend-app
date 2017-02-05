/**
 *
 */
const ACTIVE_CLASS = "active";
const STORES_TAB = "stores";
const PRODUCTS_TAB = "products";
const INFO_TAB = "info";
const REVIEWS_TAB = "reviews";
const FOLLOWERS_TAB = "followers";
//
var BrandProfile = React.createClass({
    /**
     *
     */
    getInitialState: function () {
        return {item: {}, serverLoading: false, isFollowing: false};
    },
    /**
     *
     */
    loadDataFromServer: function () {
        App.Stores.loadData({
            url: App.Routes.showBrand,
            action: App.Actions.BRAND_INOFO_CHANGED,
            params: {id: this.props.id}
        });
    },
    /**
     */
    componentDidMount: function () {
        App.Dispatcher.attach(App.Actions.BRAND_FOLLOWING, this.onFollowingChanged);
        App.Dispatcher.attach(App.Actions.BRAND_INOFO_CHANGED, this.onBrandInfoChanged);
        this.loadDataFromServer();
    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(App.Actions.BRAND_FOLLOWING, this.onFollowingChanged);
        App.Dispatcher.attach(App.Actions.BRAND_INOFO_CHANGED, this.onBrandInfoChanged);
    },
    /*

     */
    onBrandInfoChanged (brandInfo){
        if (brandInfo.id == this.props.id) {
            this.setState({
                serverLoading: false,
                item: brandInfo,
                isFollowing: brandInfo.is_following
            });
        }
    },

    /**
     *
     * @param payload
     */
    onFollowingChanged: function (payload) {
        if (payload.action && payload.data && payload.data.brand_id == this.state.item.id) {
            let isFollowing;
            if (payload.action == App.Actions.BRAND_FOLLOW) {
                isFollowing = true;
            }
            else if (payload.action == App.Actions.BRAND_UNFOLLOW) {
                isFollowing = false;
            }
            if (isFollowing != this.state.isFollowing) {
                var oldItem = this.state.item;
                oldItem.followers_count = payload.data.followers_count;
                this.setState({isFollowing: isFollowing, item: oldItem});
            }
        }
    },
    /**
     *
     */
    toggleFollowing: function () {
        let id = this.state.item.id;
        App.Stores.post({
            url: this._getFollowActionUrl(this.state.isFollowing, id),
            action: App.Actions.BRAND_FOLLOWING,
            event: {
                id: id
            }
        });
    },
    /**
     *
     * @param isFollowing
     * @param id
     * @private
     */
    _getFollowActionUrl (isFollowing, id){
        var url = isFollowing ? App.Routes.unFollowBrand : App.Routes.followBrand;
        return App.Helpers.formatApiUrl(url, {id: id});
    },
    /**
     *
     */
    onDataChange: function (result) {
        this.setState({serverLoading: true,});
    },
    /**
     *
     */
    render: function () {
        var items;
        let followingClass = this.state.isFollowing ? "ti-unlink" : "ti-link";
        var activeTab = this.props.activeTab;
        // FIXME , make this dynamic
        var tabClassInstance = null;
        // data is loaded
        if (this.state.item.id){
            switch (activeTab) {
                case INFO_TAB :
                default:
                    tabClassInstance = <BrandProfileInfo id={this.props.id} brandInfo={this.props.brandInfo}/>;
                    break;
                case STORES_TAB :
                    tabClassInstance = <BrandProfileStoresInfo positions={this.props.stores}/>;
                    break;
                case PRODUCTS_TAB :
                    tabClassInstance = <ProductsList id={this.props.id} brand={this.props.id}/>;
                    break;
                case REVIEWS_TAB :
                    tabClassInstance = <BrandProfileReviewsList
                        authenticityToken={this.props.authenticityToken}
                        id={this.props.id}/>;
                    break;
                case FOLLOWERS_TAB :
                    tabClassInstance = <BrandProfileFollowersList id={this.props.id}/>;
                    break;

            }
        }
        let container = tabClassInstance;
        return (
            <div >
                <div className="BrandDetails">
                    <div className="BrandDetails__Verified">
                        <span className="ti-shield"></span>
                    </div>
                    <div className="BrandDetails_Header">
                        <div className="BrandDetails__Title">
                            <span>{this.state.item.name}</span>
                        </div>
                        <div className="BrandDetails__ImageContainer">

                            <img className="BrandDetails__ImageCover" src={this.props.cover}/>

                        </div>
                        <button
                            className={"BrandDetails__Follow BrandCard__FollowButton--"  + (this.state.isFollowing ? "on" : "off")}
                            onClick={this.toggleFollowing}>
                            <i className={followingClass}></i>
                        </button>
                        <ul className="nav nav-tabs">
                            <li className={(activeTab == INFO_TAB || !activeTab) ? ACTIVE_CLASS : ''}>
                                <a href={App.Helpers.getAbsoluteUrl(App.Routes.brandInfo, { id : this.props.id})}>
                                    <i className="fa fa-circle"></i> Info
                                </a>
                            </li>
                            <li className={activeTab == STORES_TAB ? ACTIVE_CLASS : ''}>
                                <a href={App.Helpers.getAbsoluteUrl(App.Routes.brandStores, { id : this.props.id})}>
                                    <i className="fa fa-circle"></i> Stores ({this.state.item.stores_count})
                                </a>
                            </li>
                            <li className={activeTab == PRODUCTS_TAB ? ACTIVE_CLASS : ''}>
                                <a href={App.Helpers.getAbsoluteUrl(App.Routes.brandProducts, { id : this.props.id})}>
                                    <i className="fa fa-circle"></i> Products ({this.state.item.products_count})
                                </a>
                            </li>

                            <li className={activeTab == REVIEWS_TAB ? ACTIVE_CLASS : ''}>
                                <a href={App.Helpers.getAbsoluteUrl(App.Routes.brandReviews, { id : this.props.id})}>
                                    <i className="fa fa-circle"></i> Reviews ({this.state.item.reviews_count})
                                </a>
                            </li>
                            <li className={activeTab == FOLLOWERS_TAB ? ACTIVE_CLASS : ''}>
                                <a href={App.Helpers.getAbsoluteUrl(App.Routes.brandFollowers, { id : this.props.id})}>
                                    <i className="fa fa-circle"></i> Followers ({this.state.item.followers_count})
                                </a>
                            </li>
                        </ul>
                    </div>
                    {container}
                </div>
            </div>
        );
    }
});
