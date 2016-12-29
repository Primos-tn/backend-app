var ProductsListItem = React.createClass({
    /**
     *
     */
    actions: {
        follow: "FOLLOW",
        wish: "WISH"
    },
    /**
     *
     * @returns {{isWishing: boolean}}
     */
    getInitialState: function () {
        return {
            isWishing: this.props.item.is_wishing,
            wishersCount: this.props.item.followers
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
        var element = ReactDOM.findDOMNode(this);
        App.Dispatcher.attach(this.actions.wish, this.itemChangedListener);
    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(this.actions.wish, this.itemChangedListener);
    },
    /**
     *
     * @param data
     * @param event
     */
    itemChangedListener: function (data, event) {
        if ((event.id == this.props.item.id) && data.ok) {
            var isWishing = this.state.isWishing;
            var addFollowersCount = isWishing ? -1 : 1;
            var wishersCount = this.state.wishersCount + addFollowersCount;
            this.setState({isWishing: !isWishing, wishersCount: wishersCount});
        }

    },
    /**
     *
     * @param isWishing
     * @private
     */
    _getFollowActionUrl (isWishing){
        var url = isWishing ? App.Routes.unWishProduct : App.Routes.wishProduct;
        return App.Helpers.formatApiUrl(url, {id: this.props.item.id});
    },
    /**
     * Share action
     */
    _shareAction: function (e) {
        e.preventDefault();
        App.Stores.post({
            url: App.Helpers.formatApiUrl(App.Routes.shareProduct, {id: this.props.item.id})
        });
    },
    /**
     * Wish action
     */
    _wishAction: function (e) {
        e.preventDefault();
        App.Stores.post({
            url: this._getFollowActionUrl(this.state.isWishing),
            action: this.actions.wish,
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
        this.setState({baseImageUrl: App.Constants.MEDIA_URL + image.url}, function () {
            this.props.recalculate()
        });
    },
    /**
     *
     */
    render: function () {
        var item = this.props.item;
        var info = item.info;
        var pictures = info.pictures || [];
        var baseImageUrl = this.state.baseImageUrl;
        if (!baseImageUrl && pictures.length) {
            baseImageUrl = App.Constants.MEDIA_URL + pictures[0].url;
        }
        return (
            <div className="ProductCardContainer">

                <div className="ProductCard">

                    <div className="ProductCard__ImageContainer">

                        <a href={'products/' + info.id}>
                            <img className="ProductCard__Image" src={baseImageUrl}/>
                        </a>


                        <ProductShowGallery pictures={pictures || [] }
                                            onImageThumbnailClicked={this.onImageThumbnailClicked}/>
                        <div className="ProductCard__Name">
                            <span className="card-title">{info.name}</span>
                        </div>
                        <a className="ProductCard__BrandImageContainer"
                           href={App.Helpers.getAbsoluteUrl(App.Routes.brand, {id : item.brand.id})}>
                            <img
                                src={App.Helpers.getMediaUrl(item.brand.picture.thumb.url)}
                                alt={item.brand.name}/>
                        </a>
                        <button
                            className={"ProductCard__WishButton  ProductCard__WishButton--"  + (this.state.isWishing ? "on" : "off")}
                            onClick={this._wishAction}>
                            <i className="ti-heart"></i>
                        </button>
                        <button className="ProductCard__ShareButton" onClick={this._shareAction}>
                            <i className="ti-sharethis"></i>
                        </button>
                    </div>
                    <div className="ProductCard__Details">
                        <ProductsListItemWishersList list={item.wishers}/>
                    </div>
                </div>
            </div>
        );
    }
});