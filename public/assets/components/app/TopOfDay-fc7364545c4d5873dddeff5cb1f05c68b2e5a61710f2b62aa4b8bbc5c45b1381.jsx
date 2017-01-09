/**
 *
 */
var TopOfDayItem = React.createClass({
    /**
     *
     */
    componentDidMount: function () {
        // attribute the width
    },
    /**
     *
     */
    render: function () {
        let bg = '';
        let item = this.props.item;
        if (item.pictures && item.pictures.length && item.pictures[0].file) {
            bg = App.Helpers.getMediaUrl(item.pictures[0].file.thumb.url);
        }
        return (
            <div className="ProductOfDay__Item">
                <div className="ProductOfDay__InnerItem" style={{"backgroundImage" : 'url(' + bg + ')'}}>
                    <div className="ProductOfDay__InnerItemName">{this.props.item.name}</div>
                    <div className="ProductOfDay__InnerItemVoteNumber">15</div>
                </div>
            </div>
        )
    }

});
// app/assets/javascripts/components/article.js.jsx
var TopOfDay = React.createClass({
    /**
     *
     */
    actions: {
        PRODUCT_OF_DAY: 'PRODUCT_OF_DAY'
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
        this.setState({items: response.result});
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
        let components = null;
        if (this.state.items.length) {
            components = [];
            this.state.items.forEach(function (entry, index) {
                components.push(<TopOfDayItem key={index} item={entry}/>)
            });
        }
        return (
            <div className="ProductOfDay">
                <div className="Block__Header">
                    <span>***</span>
                </div>
                {components}
            </div>
        )
    }
});
