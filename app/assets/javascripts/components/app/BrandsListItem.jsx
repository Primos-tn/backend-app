var BrandsListItem = React.createClass({
    /**
     *
     */
    actions: {
        follow: "FOLLOW"
    },
    /**
     *
     * @returns {{isFollowing: boolean}}
     */
    getInitialState: function () {
        return {
            isFollowing: this.props.entry.is_following,
            followersCount: this.props.entry.followers
        }
    },
    /**
     */
    componentDidMount: function () {
        var element = ReactDOM.findDOMNode(this);
        App.Dispatcher.attach(this.actions.follow, this.itemChanged);
    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(this.actions.follow, this.itemChanged);
    },
    /**
     *
     * @param data
     * @param event
     */
    itemChanged: function (data, event) {
        if ((event.id == this.props.entry.id) && data.ok) {
            var isFollowing = this.state.isFollowing;
            var addFollowersCount = isFollowing ? -1 : 1;
            var followersCount = this.state.followersCount + addFollowersCount;
            this.setState({isFollowing: !isFollowing, followersCount: followersCount});
        }

    },
    /**
     *
     * @param isFollowing
     * @private
     */
    _getFollowActionUrl (isFollowing){
        var url = isFollowing ? App.Routes.unFollowBrand : App.Routes.followBrand;
        return App.Helpers.formatApiUrl(url, {id: this.props.entry.id});
    },
    /**
     *
     */
    toggleFollowing: function () {
        App.Stores.post({
            url: this._getFollowActionUrl(this.state.isFollowing),
            action: this.actions.follow,
            event: {
                id: this.props.entry.id
            }
        });
    },
    /**
     *
     */
    render: function () {
        var entry = this.props.entry;
        return (
            <div className="col-lg-6 col-sm-6" key={entry.id}>
                <div className="BrandCard">
                    <div className="BrandCard__Verified">
                        <div className="icon icon-verified"></div>
                    </div>
                    <div className="BrandCard__ImageContainer">
                        <a href={App.Helpers.getAbsoluteUrl(App.Routes.brand, {id: this.props.entry.id})}>
                            <img
                                className="BrandCard__Image"
                                src={App.Helpers.getMediaUrl(entry.cover.thumb.url)}/>
                        </a>

                    </div>


                    <div className="BrandCard__Title">
                        <span>{entry.name}</span>
                    </div>
                    <div className="BrandCard__Actions">

                        <div className="pull-right brand-btn-action center">
                            <div className="BrandCard__Followers">
                               <i className="ti-user"></i>  {entry.followers_count}
                            </div>
                        </div>
                        <button
                            className={"BrandCard__FollowButton BrandCard__FollowButton--"  + (this.state.isFollowing ? "on" : "off")}
                            onClick={this.toggleFollowing}>
                            <i className="ti-heart"></i>
                        </button>
                        <div className="clearfix"></div>
                    </div>
                </div>

            </div>
        );
    }
});