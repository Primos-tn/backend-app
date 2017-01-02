// app/assets/javascripts/components/header.js.jsx

var UserProfileSideBar = React.createClass({
    /**
     *
     */
    /**
     *
     */
    actions: {
        me: "USER_PROFILE_ME"
    },
    /**
     *
     */
    getInitialState: function () {
        return {profile: null, loading: false};
    },
    /**
     *
     */
    loadDataFromServer: function () {
        App.Stores.loadData({
            url: App.Routes.userProfile,
            params: {id: 'me'},
            action: this.actions.me
        });
    },

    /**
     *
     */
    componentDidMount: function () {
        //
        App.Dispatcher.attach(this.actions.me, this.onDataLoaded);
        this.setState({loading: true});
        this.loadDataFromServer();

    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(this.actions.me, this.onDataLoaded);
    },
    /**
     *
     * @param response
     */
    onDataLoaded  (response){
        this.setState({profile: response.result, loading: false})
    },
    /**
     *
     */
    render: function () {
        if (this.state.loading) {
            return <Loading/>;
        }
        let container = null;
        if (this.state.profile) {
            let me = this.state.profile;
            container = (
                <div className="AppSideBar__ProfileCover">
                    <i className="ti-user"></i>
                    {me.username}
                </div>

            )
        }
        return (
            <div className="AppSideBar__Profile">
                {container}
            </div>
        );
    }
});
