// app/assets/javascripts/components/article.js.jsx
var BrandsList = React.createClass({
    actions: {
        list: "BRANDS_LIST"
    },
    /**
     *
     */
    getInitialState: function () {
        return {items: [], serverLoadingDone: false};
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
    loadDataFromServer: function () {
        this.setState({serverLoadingDone: false});
        App.Stores.loadData({
            url: App.Routes.brands,
            action: this.actions.list
        });
    },
    /**
     *
     */
    onDataChange: function (result) {
        this.setState({items: result.brands, serverLoadingDone: true}, function () {});
    },
    /**
     *
     */
    render: function () {
        var items;
        if (this.state.items.length) {
            items = this.state.items.map(function (item, index) {
                return <BrandsListItem entry={item} key={index}/>;
            }.bind(this));
        }
        else {
            items = <div className="text-center">{ this.state.serverLoadingDone ?  i18n.Empty : i18n.Loading  } </div>
        }


        return (
            <div className="row col-lg-12">
                <PopularEmbedList type="Product"/>
                {items}
            </div>
        );
    },
});
