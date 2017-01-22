var ProductsListItem = React.createClass({
    /**
     *
     * @returns {{isWishing: boolean}}
     */
    getInitialState: function () {
        return {
            isVoted: this.props.item.is_voted,
            votesCount: this.props.item.info.user_product_votes_count
        }
    },
    /**
     *
     * @param withSelect
     * @returns {string}
     */
    getProgressId (withSelect = ""){
        return withSelect + 'progress_' + this.props.index
    },
    /**
     */
    componentDidMount: function () {
        //App.Dispatcher.attach(App.Actions.WISH, this.onVotedListener);
        App.Dispatcher.attach(App.Actions.PRODUCT_VOTE, this.onVotedListener);
    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(App.Actions.PRODUCT_VOTE, this.onVotedListener);

    },
    /**
     *
     * @param payload
     */
    onVotedListener: function (payload) {
        let content = payload.content ;
        if (content.action && content.data && content.data.product_id == this.props.item.id) {
            let increment = 0;
            let isVoted;
            if (content.action == App.Actions.PRODUCT_VOTE_UP) {
                increment = 1;
                isVoted = true;
            }
            else if (content.action == App.Actions.PRODUCT_VOTE_DOWN) {
                increment = -1;
                isVoted = false;
            }
            if (increment !== 0 && isVoted != this.state.isVoted) {
                var votesCount = this.state.votesCount + increment;
                this.setState({isVoted: isVoted, votesCount: votesCount});
            }
        }

    },
    /**
     *
     * @param isWishing
     * @private
     */
    _getVoteActionUrl (isVoted){
        var url = isVoted ? App.Routes.unVoteProduct : App.Routes.voteProduct;
        return App.Helpers.formatApiUrl(url, {id: this.props.item.id});
    },
    /**
     * Share action
     */
    _shareAction (e) {
        e.preventDefault();
        App.Stores.get({
            url: App.Helpers.formatApiUrl(App.Routes.shareProduct, {id: this.props.item.id})
        });
    },
    /**
     *
     * @param e
     * @private
     */
    _voteAction: function (e) {
        e.preventDefault();
        App.Stores.post({
            url: this._getVoteActionUrl(this.state.isVoted),
            action: App.Actions.PRODUCT_VOTE,
            event: {
                id: this.props.item.id
            }
        });
    },
    /**
     * Callback to change current image
     */
    onImageThumbnailClicked: function (image, event) {
        event.preventDefault();
        this.setState({baseImageUrl: App.Constants.MEDIA_URL + image.file.url});
    },
    /**
     *
     */
    render: function () {
        var item = this.props.item;
        var info = item.info;
        var pictures = item.pictures || [];
        var baseImageUrl = this.state.baseImageUrl;
        if (!baseImageUrl && pictures.length) {
            baseImageUrl = App.Constants.MEDIA_URL + pictures[0].file.url;
        }

        let voteButtonClassName = this.state.isVoted ? "ti-arrow-down" : "ti-arrow-up";
        return (
            <div className="ProductCardContainer NoPadding col-lg-6 col-sm-12">

                <div className="ProductCard">
                    <div className="ProductDetails__Menu">
                        <div className="btn-group">
                            <button type="button" onClick={this._shareAction} className="btn"><span
                                className="ti-announcement"></span></button>
                            <button type="button" onClick={this._voteAction} className="btn"><span
                                className={voteButtonClassName}></span></button>
                        </div>
                    </div>
                    <div className="ProductCard__ImageContainer">

                        <a href={'/products/' + info.id}>
                            <div className="sixteen-nine">
                                <div className="content" style={{ 'backgroundImage' : 'url(' + baseImageUrl + ')'}}>
                                </div>
                            </div>
                        </a>
                        <a className="ProductCard__BrandImageContainer"
                           href={App.Helpers.getAbsoluteUrl(App.Routes.showBrand, {id : item.brand.id})}>
                            <img
                                src={App.Helpers.getMediaUrl(item.brand.picture.thumb.url)}
                                alt={item.brand.name}/>
                        </a>

                    </div>
                    <div className="ProductCard__Details">
                        <div className="ProductCard__Name">
                            <span className="card-title">{info.name}</span>
                        </div>
                        <ProductShowGallery pictures={pictures || [] }
                                            onImageThumbnailClicked={this.onImageThumbnailClicked}/>
                        <div className="pull-right ProductCard__VotesCount">
                            {this.state.votesCount}
                        </div>
                    </div>
                </div>
            </div>
        );
    }
});
