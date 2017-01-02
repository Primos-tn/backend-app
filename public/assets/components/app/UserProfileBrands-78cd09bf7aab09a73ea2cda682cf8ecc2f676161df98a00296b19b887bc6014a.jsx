/**
 *
 */
var UserProfileBrandsItem = React.createClass({

    render (){
        let item = this.props.item ;
        return (
            <div>
                <a href={App.Helpers.getAbsoluteUrl(App.Routes.brand, {id:  item.id })}>
                    <h6>{item.name}</h6>
                    <img src={App.Helpers.getMediaUrl(item.picture.small_thumb.url)}/>
                </a>

            </div>
        )
    }
});
/**
 *
 */
var UserProfileBrands = React.createClass({
    /**
     *
     */
    actions: {
        USER_BRANDS: "USER_BRANDS"
    },
    /**
     *
     */
    getInitialState: function () {
        return {loading: false, items: []};
    },
    /**
     *
     */
    componentDidMount: function () {
        // attach events on brand
        App.Dispatcher.attach(this.actions.USER_BRANDS, this.onUserBrandsFetched);
        this.setState({loading: true});
        this._loadDataFromServer();
    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(this.actions.USER_BRANDS, this.onUserBrandsFetched);
        // attach events on brand
    },

    /**
     *
     */
    _loadDataFromServer: function () {
        App.Stores.loadData({
            url: App.Routes.userBrands,
            params: {id: this.props.id},
            action: this.actions.USER_BRANDS
        });
    },
    /**
     *
     */
    onUserBrandsFetched: function (response) {
        this.setState({loading: false, items: response.list});
    },
    /**
     *
     */
    render: function () {
        if (this.state.loading) {
            return <Loading/>;
        }
        let items = [];
        var i = 0;
        this.state.items.forEach(function (item, index) {
            items.push(<UserProfileBrandsItem item={item} key={index + i++}/>);
        }.bind(this));
        // "http://feelgrafix.com/data_images/out/24/944648-nature.jpg"
        return (
            <div className="UserProfilePage_BrandsList">
                {items}
            </div>
        );
    }
});
