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
            wishersCount: this.props.item.wishers_count
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
    _shareAction (e) {
        e.preventDefault();
        App.Stores.get({
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
     * Share action
     */
    _viewCouponAction  (e) {
        e.preventDefault();
        App.Stores.loadData({
            url: App.Helpers.formatApiUrl(App.Routes.productCoupons, {id: this.props.item.id})
        });
    },
    /**
     * Callback to change current image
     */
    onImageThumbnailClicked: function (image, event) {
        event.preventDefault();
        this.setState({baseImageUrl: App.Constants.MEDIA_URL + image.file.url}, function () {
            this.props.recalculate()
        });
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
        return (
            <div className="ProductCardContainer NoPadding col-lg-6 col-sm-12">

                <div className="ProductCard">
                    <div className="ProductDetails__Menu">
                        <div className="btn-group">
                            <button type="button" onClick={this._shareAction} className="btn btn-warning"> <i className="ti-share"></i></button>
                            <button type="button" onClick={this._wishAction} className="btn btn-warning"> <i className="ti-heart"></i></button>
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
                           href={App.Helpers.getAbsoluteUrl(App.Routes.brand, {id : item.brand.id})}>
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
                        <ProductsListItemWishersList list={item.wishers}/>
                    </div>
                </div>
            </div>
        );
    }
});