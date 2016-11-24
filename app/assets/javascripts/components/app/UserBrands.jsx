/**
 *
 */
var UserBrands = React.createClass({
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
        return {loading : false, brands : []};
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
            action : this.actions.USER_BRANDS
        });
    },
    /**
     *
     */
    onUserBrandsFetched: function (response) {
        this.setState({loading: false, brands : response.result});
    },
    /**
     *
     */
    render: function () {
        if (this.state.loading) {
            return <div>Loading</div>
        }
        var info = this.state.brands;
        // "http://feelgrafix.com/data_images/out/24/944648-nature.jpg"
        return (
            <div>
                Brands
            </div>
        );
    }
});
