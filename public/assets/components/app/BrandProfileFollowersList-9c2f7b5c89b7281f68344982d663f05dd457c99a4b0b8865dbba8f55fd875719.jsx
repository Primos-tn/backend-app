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
    getInitialState (){
        return {
            items: [],
            noMoreItems: false,
            isFetchingItems: false,
            page: 0,
            maxItems: 10
        }
    },
    /**
     *
     */
    fetchItems () {
        // get query
        let query = {page: this.state.page};
        //
        this.setState({isFetchingItems: true});
        //
        App.Stores.loadData({
            url: App.Routes.brandFollowers,
            action: App.Actions.BRAND_FOLLOWERS_LIST_FETCHING,
            params: {id: this.props.id},
            query: query
        });
    },

    /**
     *
     */
    componentDidMount () {
        App.Dispatcher.attach(App.Actions.BRAND_FOLLOWERS_LIST_FETCHING, this.onDataChange);
        this.fetchItems();
    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(App.Actions.BRAND_FOLLOWERS_LIST_FETCHING, this.onDataChange);
    },
    /**
     *
     */
    onDataChange: function (result) {
        let followers = result.followers;
        // there's more
        if (followers.length) {
            this.setState({
                items: this.state.items.concat(followers),
                isFetchingItems: false
            });
        }
        if (followers.length < this.state.maxItems) {
            this.setState({noMoreItems: true});
        }
        else {
            this.setState({noMoreItems: false});
        }
    },
    /**
     *
     */
    render: function () {
        var items;
        var bottomLoading = this.state.isFetchingItems ? <Loading/> : "";
        if (this.state.items.length) {
            items = this.state.items.map(function (item, index) {
                return <BrandProfileFollowersListItem entry={item} key={index}/>;
            }.bind(this));
        }
        else {
            if (this.state.isFetchingItems) {
                items = <Fetching />
            }
            else {
                items = <EmptyList />
            }
            bottomLoading = "";
        }
        return (
            <div>
                {items}
                {bottomLoading}
            </div>
        );
    },
});