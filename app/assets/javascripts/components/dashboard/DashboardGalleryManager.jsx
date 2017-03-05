let MODAL_GALLERY_ITEMS_SELECTED = 'modal:gallery:items:selected';
let MODAL_GALLERY_OPEN = 'modal:gallery:open';
/**
 *
 */
var DashboardGalleryModal = React.createClass({
    /**
     *
     */
    getInitialState (){
        return {items: [], isFetching: false, selected_items: []};
    },
    /**
     *
     * @private
     */
    _loadDataServer () {
        $.get(App.DashboradRoutes.galleryList, this._galleryLoaded);
    },

    /**
     *
     * @private
     */
    _galleryLoaded (response) {
        this.setState({isFetching: true});
        this.setState({items: response.list, isFetching: false});
    },
    /**
     *
     */
    componentDidMount() {
        // FIXME , move action to constants
        App.Dispatcher.attach(MODAL_GALLERY_OPEN, this.showModal);
    },
    /**
     *
     */
    showModal() {
        this.setState({selected_items: []});
        $(ReactDOM.findDOMNode(this)).modal();
        this._loadDataServer()
    },
    /**
     *
     * @param entry
     * @param e
     * @private
     */
    _selectImage (entry, e){
        $(e.currentTarget).css({'border': 'solid'});
        var old_values = this.state.selected_items;
        var exists = false;
        var i = 0;
        while (!exists && i < old_values.length) {
            if (entry.id == old_values[i++].id) {
                exists = true;
            }
        }
        // if not contains
        if (!exists) {
            old_values.push(entry);
            this.setState({selected_items: old_values})
        }
    },
    /**
     *
     */
    _closeModal (){
        App.Dispatcher.dispatch(MODAL_GALLERY_ITEMS_SELECTED, {items: this.state.selected_items});
        $(ReactDOM.findDOMNode(this)).modal('hide');
    },
    /**
     *
     */
    componentWillUnmount () {

    },
    /**
     *
     * @returns {XML}
     */
    render: function () {
        let components = null;
        if (this.state.items.length) {
            components = [];
            this.state.items.forEach(function (entry) {
                components.push(
                    <div className="col-lg-3"><img className="img-responsive"
                                                   onClick={this._selectImage.bind(this, entry)}
                                                   src={App.Helpers.getMediaUrl(entry.file.thumb.url)}/></div>
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
                            <h4 className="modal-title">{i18n.GalleryTitle}</h4>
                        </div>
                        <div className="modal-body">
                            {this.isFetching ? i18n.Loading : components }
                        </div>
                        <div className="modal-footer">
                            <button type="button" className="btn btn-default"
                                    onClick={this._closeModal}>{i18n.Confirm}</button>
                            <button type="button" className="btn btn-default" data-dismiss="modal">{i18n.Close}</button>

                        </div>
                    </div>

                </div>
            </div>
        )
    }
});


// app/assets/javascripts/components/article.js.jsx
var DashboardGalleryModalManager = React.createClass({
    /**
     *
     */
    showModal (e) {
        e.preventDefault();
        App.Dispatcher.dispatch(MODAL_GALLERY_OPEN);
    },
    /**
     *
     */
    componentDidMount(){
        App.Dispatcher.attach(MODAL_GALLERY_ITEMS_SELECTED, this.onGalleryItemsSelected);
        new Dropzone($(ReactDOM.findDOMNode(this))
            .find('#gallery_uploader').first()[0],
            {
                url: this.props.upload_url,
                params: {
                    authenticity_token : this.props.authenticity_token
                },
                init : function (){
                    this.on("success", function (file, response) {
                        App.Dispatcher.dispatch(MODAL_GALLERY_ITEMS_SELECTED, {items : [response]});
                        this.removeFile(file);
                    });
                }
            });
    },
    /**
     *
     */
    onGalleryItemsSelected (data){
        var items = data.items;
        var $container = $('#product_pictures_containers');
        var $lastItem = $container.find('.ProductPictureItem').last();
        var $newItem;
        var $checkbox;
        var $image;
        items.forEach(function (picture) {
            $newItem = $lastItem.clone();
            var form_id = 'product_picture_ids' + picture.id;
            // check if there's one
            if ($container.find('#' + form_id).length == 0) {
                $newItem.find('label').attr('for', form_id);
                $checkbox = $newItem.find('input[type=checkbox]');
                $checkbox.attr('id', form_id);
                $checkbox.attr('checked', true);
                $checkbox.attr('value', picture.id);
                $image = $newItem.find('img');
                $image.attr('src', App.Helpers.getMediaUrl(picture.file.thumb.url));
                $newItem.insertBefore($lastItem);
                $newItem.show();
            }
        })
        //
    },
    /**
     *
     */
    render () {
        return (
            <div>
                <div id="gallery_uploader">
                    {i18n.Upload}
                </div>
                <button className="btn btn-default" onClick={this.showModal.bind(this)}>
                    {i18n.FromGallery}
                </button>
            </div>

        )
    }
});
