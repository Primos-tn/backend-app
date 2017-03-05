/**
 *
 */
var QUERY_ID = "with_product_id";
var DashboardCollectionsProductModal = React.createClass({

    /**
     *
     */
    getInitialState (){
        return {productsCollections: [], isFetching: false};
    },
    /**
     *
     * @private
     */
    _loadDataServer () {
        var queryObject = {};
        queryObject[QUERY_ID] = this.state.productId;
        $.get(App.Helpers.formatApiUrl(App.DashboradRoutes.collections, {}, queryObject), this._productsCollectionsLoaded);
    },

    /**
     *
     * @private
     */
    _productsCollectionsLoaded (response) {
        this.setState({isFetching: true});
        this.setState({productsCollections: response.list, isFetching: false});
    },
    /**
     *
     */
    componentDidMount() {
        App.Dispatcher.attach(App.Actions.DASHBOARD_MODAL_COLLECTION_OPEN, this.showModal);
        App.Dispatcher.attach(App.Actions.DASHBOARD_MODAL_COLLECTION_ITEMS_MODIFIED, this.onItemAdded);
    },

    /**
     *
     */
    componentWillUnmount() {
        App.Dispatcher.detach(App.Actions.DASHBOARD_MODAL_COLLECTION_OPEN, this.showModal);
        App.Dispatcher.detach(App.Actions.DASHBOARD_MODAL_COLLECTION_ITEMS_MODIFIED, this.onItemAdded);
    },
    /**
     *
     */
    showModal(data) {
        this.setState({collections: [], productId: data.productId}, function () {
            $(ReactDOM.findDOMNode(this)).modal();
            this._loadDataServer()
        });
    },
    /**
     *
     */
    _closeModal (){
        $(ReactDOM.findDOMNode(this)).modal('hide');
    },
    /**
     *
     */
    onItemAdded (serverData, eventSource){
        //alert(JSON.stringify(eventSource));
        if (serverData.products) {
            // enable all buttons
            $(ReactDOM.findDOMNode(this)).find('button').removeAttr('disabled');
            let collections = this.state.productsCollections;
            collections.forEach(function (entry) {
                if (eventSource.id == entry.id) {
                    // alert('change');
                    entry.products = serverData.products
                }
            });
            // alert(JSON.stringify(collections));
            //
            this.setState({productsCollections: collections});
        }
    },
    /**
     * Add / delete product from collection
     * @param entry
     * @param isIn
     * @param e
     * @private
     */
    _selectItem (entry, isIn, e){
        // FIXME , disable the e.source.target
        // disable  all buttons
        //$(ReactDOM.findDOMNode(this)).find('button').attr('disabled', 'disable');
        App.Stores.post({
            url: isIn ? App.DashboradRoutes.collectionsItemRemove : App.DashboradRoutes.collectionsItemAdd,
            params: {id: entry.id},
            data: {
                product_id: this.state.productId
            },
            action: App.Actions.DASHBOARD_MODAL_COLLECTION_ITEMS_MODIFIED,
            // pass the collection id to success or fails
            event: {id: entry.id}
        }, this._productsCollectionsLoaded);
    },
    /**
     *
     * @returns {XML}
     */
    render: function () {
        let components = null;
        if (this.state.productsCollections.length) {
            components = [];
            let currentProductId = this.state.productId;
            // check the product inside the collection or not
            let isIn = false;
            let i = 0;
            this.state.productsCollections.forEach(function (entry) {
                isIn = false;
                i = 0;
                while (!isIn && i < entry.products.length) {
                    isIn = entry.products[i].id == currentProductId;
                    i++;
                }
                components.push(
                    <div className="col-lg-3">
                        {entry.name} ({entry.products.length})
                        <button
                            className={"btn btn-sm ProductAddToCollectionButton " + (isIn ? "btn-danger" : "btn-success") }
                            onClick={this._selectItem.bind(this, entry, isIn)}> {isIn ? i18n.Remove : i18n.Add}</button>
                    </div>
                )
            }.bind(this));
            components.push(<div className="clearfix"></div>);
        }
        else {
            components = [];
            components.push(
                <div>Empty</div>
            )
        }
        return (
            <div className="modal fade" role="dialog">
                <div className="modal-dialog modal-lg">
                    <div className="modal-content">
                        <div className="modal-header">
                            <button type="button" className="close" data-dismiss="modal">&times;</button>
                            <h4 className="modal-title">{i18n.CollectionProductTitle}</h4>
                        </div>
                        <div className="modal-body">
                            {this.isFetching ? i18n.Loading : components }
                        </div>
                        <div className="modal-footer">
                            <button type="button" className="btn btn-default" data-dismiss="modal">{i18n.Close}</button>
                        </div>
                    </div>

                </div>
            </div>
        )
    }
});


// app/assets/javascripts/components/article.js.jsx
var DashboardCollectionProductModalButtonLauncher = React.createClass({
    /**
     *
     */
    showModal (productId, e) {
        e.preventDefault();
        App.Dispatcher.dispatch(App.Actions.DASHBOARD_MODAL_COLLECTION_OPEN, {productId: productId});
    },
    /**
     *
     */
    componentDidMount(){
        App.Dispatcher.attach(MODAL_GALLERY_ITEMS_SELECTED, this.onCollectionProductItemSelected);
    },
    /**
     *
     */
    onCollectionProductItemSelected (data){

        //
    },
    /**
     * // <%= link_to '+' + I18n.t('Add to collection'), launch_dashboard_product_path(product), method: :post, :class => '', data: {confirm: I18n.t('Are you sure about that')} %>
     */
    render () {
        return (
            <button className=" btn-sm btn btn-danger" onClick={this.showModal.bind(this, this.props.product_id)}>
                {this.props.text}
            </button>

        )
    }
});
