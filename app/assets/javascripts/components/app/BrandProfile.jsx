/**
 *
 */
const ACTIVE_CLASS = "active";


const WISHERS_TAB = "wishers";
const STORES_TAB = "stores";
const PRODUCTS_TAB = "products";
const INFO_TAB = "info";
const FOLLOWERS_TAB = "followers";
const REVIEWS_TAB = "reviews";

var BrandProfile = React.createClass({
    /**
     *
     */
    loadDataFromServer: function () {
        App.Stores.loadData({
            url: App.Routes.brand,
            params: {id: this.props.id}
        });
    },

    /**
     *
     */
    componentDidMount: function () {
        // attach events on brand
        this.loadDataFromServer();
    },
    /**
     *
     */
    componentWillUnmount: function () {
        // attach events on brand
    },
    /**
     *
     */
    getInitialState: function () {
        return {item: null, serverLoadingDone: false};
    },
    /**
     *
     */
    onDataChange: function (result) {
        this.setState({serverLoadingDone: true});
    },
    /**
     *
     */
    render: function () {
        var items;
        var activeTab = this.props.activeTab;
        //
        if (this.state.item) {
            items = this.state.items.map(function (item, index) {
                return <ProductsListItem item={item} key={index}/>;
            }.bind(this));
        }
        else {
            items = this.state.serverLoadingDone ? '0 items ' : "Loading ....";
        }
        // FIXME , make this dynamic
        var tabClassInstance = null;
        switch (activeTab) {
            case STORES_TAB :
                tabClassInstance = <BrandProfileStoresInfo />;
                break;
            case PRODUCTS_TAB :
                tabClassInstance = <ProductsList id={this.props.id} brand={this.props.id}/>;
                break;
            case REVIEWS_TAB :
                tabClassInstance = <BrandProfileReviewsList id={this.props.id}/>;
                break;
            case FOLLOWERS_TAB :
                tabClassInstance = <BrandProfileFollowersList id={this.props.id}/>;
                break;
            case INFO_TAB :
            default:
                tabClassInstance = <BrandProfileInfo id={this.props.id}/>;
        }
        let container = tabClassInstance;
        return (
            <div >
                <div className="BrandDetails">
                    <div>
                        <div className="BrandDetails__ImageContainer">

                            <img className="BrandDetails__ImageCover" src={this.props.cover}/>

                        </div>
                        <ul className="nav nav-tabs">
                            <li className={activeTab == STORES_TAB ? ACTIVE_CLASS : ''}>
                                <a href={App.Helpers.getAbsoluteUrl(App.Routes.brandStores, { id : this.props.id})}>
                                    <i className="fa fa-circle"></i> Stores
                                </a>
                            </li>
                            <li className={activeTab == PRODUCTS_TAB ? ACTIVE_CLASS : ''}>
                                <a href={App.Helpers.getAbsoluteUrl(App.Routes.brandProducts, { id : this.props.id})}>
                                    <i className="fa fa-circle"></i> Products
                                </a>
                            </li>
                            <li className={(activeTab == INFO_TAB || !activeTab) ? ACTIVE_CLASS : ''}>
                                <a href={App.Helpers.getAbsoluteUrl(App.Routes.brandInfo, { id : this.props.id})}>
                                    <i className="fa fa-circle"></i> Info
                                </a>
                            </li>
                            <li className={activeTab == REVIEWS_TAB ? ACTIVE_CLASS : ''}>
                                <a href={App.Helpers.getAbsoluteUrl(App.Routes.brandReviews, { id : this.props.id})}>
                                    <i className="fa fa-circle"></i> Reviews
                                </a>
                            </li>
                            <li className={activeTab == FOLLOWERS_TAB ? ACTIVE_CLASS : ''}>
                                <a href={App.Helpers.getAbsoluteUrl(App.Routes.brandFollowers, { id : this.props.id})}>
                                    <i className="fa fa-circle"></i> Followers
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
