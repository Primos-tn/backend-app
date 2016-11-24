/**
 *
 */
var ProductsList = React.createClass({
    /**
     *
     */
    actions: {
        list: "PRODUCTS_LIST"
    },
    /**
     *
     */
    loadDataFromServer: function () {
        App.Stores.loadData({
            url: App.Routes.products,
            action: this.actions.list,
            query: {
                brand: this.props.brand
            }
        });
    },

    /**
     *
     */
    componentDidMount: function () {
        App.Dispatcher.attach(this.actions.list, this.onDataChange);
        this.loadDataFromServer();

    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(this.actions.list, this.onDataChange);
    },
    /**
     *
     */
    getInitialState: function () {
        return {items: [], serverLoadingDone: false};
    },
    /**
     *
     * @param direction
     * @private
     */
    _recalculateGrid(direction){
        let x = 0, leftY = 0, rightY = 0;
        $('.ProductCard').each(function (index) {
            console.log(index);
            $(this).parent().css('left', x);
            if (index % 2) {
                console.log('left');
                $(this).parent().css('top', rightY);
                $(this).parent().css('marginLeft', "1%");
                rightY += $(this).height() + 15;
                x = -15;
            }
            else {
                console.log('right');
                x = $(this).width() + 15;
                $(this).parent().css('top', leftY);
                $(this).parent().css('marginRight', "1%");
                leftY += $(this).height() + 15;
            }
        });
        $('.ProductCardLisContainer').height(Math.max(leftY, rightY));
    },
    /**
     *
     */
    onDataChange: function (result) {
        this.setState({items: result.products, serverLoadingDone: true}, function () {
            //
            this._recalculateGrid();
        });
    },
    /**
     *
     */
    render: function () {
        var items;
        //
        if (this.state.items.length) {
            items = [];
            var i = 0;
            this.state.items.forEach(function (item, index) {
                items.push(<ProductsListItem item={item} index={i} key={index + i++}/>);
                items.push(<ProductsListItem item={item} index={i} key={index + i++}/>);
            }.bind(this));

        }
        else {
            items = this.state.serverLoadingDone ? '0 items ' : "Loading ....";
        }

        return (
            <div>
                <div className="ProductCardLisContainer">
                    {items}
                </div>
            </div>
        );
    },
});
