/**
 *
 */
var UserProfile = React.createClass({
    /**
     *
     */
    actions: {
        USER_DATA: "USER_DATA"
    },
    /**
     *
     */
    getInitialState: function () {
        return {loading: false, userInformation: {}};
    },
    /**
     *
     */
    componentDidMount: function () {
        // attach events on brand
        App.Dispatcher.attach(this.actions.USER_DATA, this.onUserDataFetched);
        this.setState({loading: true});
        this._loadDataFromServer();
    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(this.actions.USER_DATA, this.onUserDataFetched);
        // attach events on brand
    },

    /**
     *
     */
    _loadDataFromServer: function () {
        App.Stores.loadData({
            url: App.Routes.userProfile,
            params: {id: this.props.id},
            action: this.actions.USER_DATA
        });
    },
    /**
     *
     */
    onUserDataFetched: function (response) {
        this.setState({loading: false, userInformation: response.result});
    },
    /**
     *
     */
    render: function () {
        if (this.state.loading) {
            return <Loading/>;
        }
        var info = this.state.info;
        return (
            <div className="UserProfilePage">
                <div class="UserProfilePage__UserName">
                    {this.state.userInformation.username}
                </div>
                <h4>{i18n.Brands} : {this.state.userInformation.brands}</h4>
                <UserProfileBrands id={this.props.id}/>
            </div>
        );
    }
});
