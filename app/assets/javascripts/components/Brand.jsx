var Brand = React.createClass({
    actions : {
        follow : "FOLLOW"
    },
    /**
     *
     * @returns {{isFollowing: boolean}}
     */
    getInitialState : function (){
        return {
            isFollowing : this.props.item.isFollowing,
            followersCount : this.props.item.followers
        }
    },
    /**
     */
    componentDidMount : function (){
        App.Dispatcher.attach(this.actions.follow, this.itemChanged);
    },
    /**
     *
     */
    componentWillUnmount : function (){
        App.Dispatcher.detach (this.actions.follow, this.itemChanged);
    },
    /**
     *
     * @param data
     * @param event
     */
    itemChanged : function (data, event){
        if ((event.id == this.props.item.id) && data.ok){
            var isFollowing = this.state.isFollowing ;
            var addFollowersCount =  isFollowing ? -1 : 1;
            var followersCount = this.state.followersCount +  addFollowersCount ;
            this.setState({isFollowing : !isFollowing, followersCount : followersCount});
        }

    },
    /**
     *
     * @param isFollowing
     * @private
     */
    _getFollowActionUrl (isFollowing){
        var url = isFollowing ? App.Routes.unFollowBrand : App.Routes.followBrand ;
        return App.Helpers.formatUrl(url, {id : this.props.item.id});
    },
    /**
     *
     */
    onToggle : function (){
        App.Stores.post({
            url : this._getFollowActionUrl(this.state.isFollowing),
            action : this.actions.follow,
            event : {
                id : this.props.item.id
            }
        });
    },
    /**
     *
     */
    render : function (){
        var item = this.props.item ;

        return (
            <li className="article" key={item.id}>
                <h2 className="name">{item.name}</h2>
                <div className="switcher">
                    <ButtonToggle Toggle key={item.id} isFollowing={this.state.isFollowing}  index={item.id} onToggle={this.onToggle}/>
                </div>
                <ul className="details">
                    <li className="info">
                        <span className="label">by  {item.owner}</span>
                    </li>

                    <li className="info">
                        <span className="label">{this.state.followersCount} followers</span>
                    </li>
                    <li className="info">
                        <button className="button button-share"></button>
                    </li>
                </ul>
            </li>
        );
    }
});