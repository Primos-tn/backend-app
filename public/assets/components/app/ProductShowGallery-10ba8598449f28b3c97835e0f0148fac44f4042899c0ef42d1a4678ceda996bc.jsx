/**
 *
 */
var ProductShowGallery = React.createClass({
    /**
     *
     */
    render: function () {
        var pictures = [];
        var i = 0;
        this.props.pictures.forEach(function (item){
            pictures.push(<img key={i++}
                               onClick={this.props.onImageThumbnailClicked.bind(this, item)}
                               src={App.Constants.MEDIA_URL  + item.file.thumb.url}/>)
        }.bind(this));

        return (
            <div className="Product_GalleryThumbnails">
                {pictures}
            </div>
        );
    }
});
