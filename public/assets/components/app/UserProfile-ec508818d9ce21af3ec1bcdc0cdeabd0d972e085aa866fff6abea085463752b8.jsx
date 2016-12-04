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
        return {loading : false, info : {}};
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
            action : this.actions.USER_DATA
        });
    },
    /**
     *
     */
    onUserDataFetched: function (response) {
        this.setState({loading: false, info : response.result});
    },
    /**
     *
     */
    render: function () {
        if (this.state.loading) {
            return <div>Loading</div>
        }
        var info = this.state.info;
        // "http://feelgrafix.com/data_images/out/24/944648-nature.jpg"
        return (
            <div className="AppSideBar__Profile">
                <div className="AppSideBar__ProfileCover">
                    <img src={info.avatar}/>
                </div>
            </div>
        );
    }
});
