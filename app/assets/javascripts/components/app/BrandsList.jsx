// app/assets/javascripts/components/article.js.jsx
var BrandsList = React.createClass({
    actions: {
        list: "BRANDS_LIST"
    },
    /**
     *
     */
    loadDataFromServer: function () {
        App.Stores.loadData({
            url: App.Routes.brands,
            action: this.actions.list
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
        App.Dispatcher.detach(this.actions.list, this.onDataChangeListener);
    },
    /**
     *
     */
    getInitialState: function () {
        return {items: []};
    },
    /**
     *
     */
    onDataChange: function (result) {
        this.setState({items: result.brands});
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
            items = "Loading ...."
        }


        return (
            <div className="row col-lg-12">
                <PopularEmbedList type="Product"/>
                {items}
            </div>
        );
    },
});
