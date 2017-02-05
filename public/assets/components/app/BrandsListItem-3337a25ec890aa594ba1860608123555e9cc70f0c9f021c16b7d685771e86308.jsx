var BrandsListItem = React.createClass({
    /**
     *
     * @returns {{isFollowed: boolean}}
     */
    getInitialState: function () {
        return {
            isFollowed: this.props.item.is_following,
            followersCount: this.props.item.followers_count,
            isFollowing : false
        }
    },
    /**
     */
    componentDidMount: function () {
        App.Dispatcher.attach(App.Actions.BRAND_FOLLOWING, this.onFollowingChanged);
    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(App.Actions.BRAND_FOLLOWING, this.onFollowingChanged);
    },
    /**
     *
     * @param data
     */
    onFollowingChanged: function (payload) {
        if (payload.action && payload.data && payload.data.brand_id == this.props.item.id) {
            let increment = 0;
            let isFollowed;
            if (payload.action  == App.Actions.BRAND_FOLLOW) {
                increment = 1;
                isFollowed = true;
            }
            else if (payload.action == App.Actions.BRAND_UNFOLLOW) {
                increment = -1;
                isFollowed = false;
            }
            if (increment !== 0 && isFollowed != this.state.isFollowed) {
                var followersCount = this.state.followersCount + increment;
                this.setState({isFollowed: isFollowed, followersCount: followersCount});
            }

        }

        if (this.state.isFollowing){
            this.setState({isFollowing : false})
        }

    },
    /**
     *
     * @param isFollowed
     * @param id
 * @private
     */
    _getFollowActionUrl (isFollowed, id){
        var url = isFollowed ? App.Routes.unFollowBrand : App.Routes.followBrand;
        return App.Helpers.formatApiUrl(url, {id: id});
    },
    /**
     *
     */
    toggleFollowing: function () {
        if (!this.state.isFollowing) {
            this.setState({isFollowing : true});
            let id = this.props.item.id;
            App.Stores.post({
                url: this._getFollowActionUrl(this.state.isFollowed, id),
                action: App.Actions.BRAND_FOLLOWING,
                event: {
                    id: id
                }
            });
        }
    },
    /**
     *
     */
    render: function () {
        var item = this.props.item;
        let followingClass  = this.state.isFollowing ? "ti-reload" : this.state.isFollowed ? "ti-unlink" : "ti-link" ;
        return (
            <div className="col-lg-6 col-sm-6 col-xs-12 NoPadding" key={item.id}>
                <div className="BrandCard">
                    <div className="BrandCard__Verified">
                        <span className="ti-shield"></span>
                    </div>
                    <div className="BrandCard__ImageContainer">
                        <a href={App.Helpers.getAbsoluteUrl(App.Routes.showBrand, {id: this.props.item.id})}>
                            <img
                                className="BrandCard__Image"
                                src={App.Helpers.getMediaUrl(item.cover.thumb.url)}/>
                        </a>

                    </div>


                    <div className="BrandCard__Title">
                        <span>{item.name}</span>
                    </div>
                    <div className="BrandCard__Actions">

                        <div className="pull-right brand-btn-action center">
                            <div className="BrandCard__Followers">
                                <i className="ti-user"></i> {this.state.followersCount}
                            </div>
                        </div>
                        <button
                            className={"BrandCard__FollowButton BrandCard__FollowButton--"  + (this.state.isFollowed ? "on" : "off")}
                            onClick={this.toggleFollowing}>
                            <i className={followingClass}></i>
                        </button>
                        <div className="clearfix"></div>
                    </div>
                </div>

            </div>
        );
    }
});