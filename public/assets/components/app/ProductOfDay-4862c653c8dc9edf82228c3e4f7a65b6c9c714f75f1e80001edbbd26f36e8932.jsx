// app/assets/javascripts/components/article.js.jsx
var ProductOfDay = React.createClass({
    /**
     *
     */
    actions : {
        PRODUCT_OF_DAY : 'PRODUCT_OF_DAY'
    },

    /**
     *
     */
    getInitialState: function () {
        return {item: null};
    },

    /**
     *
     */
    componentDidMount: function () {
        App.Dispatcher.attach(this.actions.PRODUCT_OF_DAY, this.onDataChange);
        this.loadDataFromServer();
    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(this.actions.PRODUCT_OF_DAY, this.onDataChange);
    },
    /**
     *
     */
    onDataChange: function (response) {
        this.setState({item : response.result});
    },
    /**
     *
     */
    loadDataFromServer: function () {
        App.Stores.loadData({
            url: App.Routes.productOfDay,
            action: this.actions.PRODUCT_OF_DAY
        });
    },

    /**
     *
     */
    render: function () {
        let component = null ;
        if (this.state.item){
            component = <div className="jumbotron ProductOfDay__Inner">{ this.state.item.name }</div> ;
        }
        return (
            <div className="ProductOfDay">
                <div>
                    {component}
                </div>
            </div>
        )
    }
});
