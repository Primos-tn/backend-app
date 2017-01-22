/**
 *
 //
 if (this.state.item) {
            items = this.state.items.map(function (item, index) {
                return <ProductsListItem item={item} key={index}/>;
            }.bind(this));
        }
 else {
            items = this.state.serverLoadingDone ? <Loading/> : <EmptyList/>;
        }
 */
var BrandProfileInfo = React.createClass({

    /**
     *
     */
    render: function () {
        return (
            <div>
                Info
            </div>
        )
    }
});
