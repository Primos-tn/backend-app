/**
 *
 */
var ProductDominantColorGallery = React.createClass({
    /**
     *
     */
    render: function () {
        var colors = [];
        var i = 0;
        this.props.dominantColors.forEach(function (entry) {
            colors.push(<div className="FilterBlock__ColorChoices" style={{"background" : entry}}></div>)
        });

        return (
            <div className="FilterBlock__ColorChoicesContainer">
                {colors}
            </div>
        );
    }
});

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
        this.props.pictures.forEach(function (item) {
            pictures.push(
                //<div>
                <img key={i++}
                     onClick={this.props.onImageThumbnailClicked.bind(this, item)}
                     src={App.Constants.MEDIA_URL  + item.file.thumb.url}/>
                //  <ProductDominantColorGallery dominantColors={item.dominant_colors || [] }/>
                //</div>
            );
        }.bind(this));

        return (
            <div className="Product_GalleryThumbnails">
                {pictures}

            </div>
        );
    }
});