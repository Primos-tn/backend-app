let BRAND_FOLLOWERS_ACTION = "BRAND_FOLLOWERS_ACTION";
var BrandProfileFollowersListItem = React.createClass({
    /**
     *
     */
    render: function () {
        return (
            <div className="BrandCard__Follower">
                <img src="https://s-media-cache-ak0.pinimg.com/avatars/tatianamamaeva_1382583329_30.jpg"/>
            </div>
        )

    }
});
/**
 *
 */
var BrandProfileFollowersList = React.createClass({
    /**
     *
     */
    loadDataFromServer: function () {
        //
        this.setState({isFetching: true});
        //
        App.Stores.loadData({
            url: App.Routes.brandFollowers,
            action: BRAND_FOLLOWERS_ACTION,
            params: {id: this.props.id}
        });
    },

    /**
     *
     */
    componentDidMount: function () {
        App.Dispatcher.attach(BRAND_FOLLOWERS_ACTION, this.onDataChange);
        this.loadDataFromServer();
    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(BRAND_FOLLOWERS_ACTION, this.onDataChange);
    },
    /**
     *
     */
    getInitialState: function () {
        return {items: [], isFetching: false};
    },
    /**
     *
     */
    onDataChange: function (result) {
        this.setState({items: result.followers, isFetching: false});
    },
    /**
     *
     */
    render: function () {
        var items;
        if (this.state.items.length) {
            items = this.state.items.map(function (item, index) {
                return <BrandProfileFollowersListItem entry={item} key={index}/>;
            }.bind(this));
        }
        else {
            if (this.state.isFetching) {
                items = <Fetching />
            }
            else {
                items = <EmptyFollowersList />
            }
        }


        return (
            <div>
                {items}
            </div>
        );
    },
});