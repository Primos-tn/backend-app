var ProductsListItemWishersListItem = React.createClass({
    /**
     *
     */
    render: function () {
        return (
            <div className="ProductCard__WisherListItem">
                <img src="https://s-media-cache-ak0.pinimg.com/avatars/tatianamamaeva_1382583329_30.jpg"/>
            </div>
        )

    }
});
var ProductsListItemWishersList = React.createClass({
    /**
     *
     */
    render: function () {
        /**
         *
         * @type {Array}
         */
        var items = this.props.list.map(function (entry){
            return <ProductsListItemWishersListItem item={{id : entry}}/>
        });
        return (
            <div className="ProductCard__WishersList">
                {items}
                <div className="ProductCard__WishersListMore">
                   <i className="ti-eye"></i> {items.length}
                </div>
            </div>
        )
    }
});