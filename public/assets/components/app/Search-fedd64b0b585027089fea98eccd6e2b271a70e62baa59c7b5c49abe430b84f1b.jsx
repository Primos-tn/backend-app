//
var Search = React.createClass({
    /**
     *
     */
    getInitialState: function () {
        return {searchResults: [], searchFor: 'products'};
    },
    /**
     *
     */
    loadDataFromServer: function (query) {
        /*App.Stores.loadData({
         ,
         action: App.Actions.SEARCH,
         data : {query : query, searchType : App.Actions.AUTO_COMPLETE}
         });*/
    },

    /**
     */
    componentDidMount: function () {
        var $container = $(ReactDOM.findDOMNode(this)) ;
        $container.find('input').autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: App.Routes.search,
                    data: {query: request.term},
                    success: function (data) {
                        var transformed = $.map(data, function (el) {
                            return {
                                label: el.name,
                                id: el.id
                            };
                        });
                        response(transformed);
                    },
                    error: function () {
                        response([]);
                    }
                });
            },
            minLength: 0,
            classes: {
                "ui-autocomplete": "highlight"
            },
            appendTo: $container
        });

        App.Dispatcher.attach(App.Actions.SEARCH, this._searchChanged);
        App.Dispatcher.attach(App.Actions.TAB_CHANGED, this._searchTypeChanged);
    },
    /**
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(App.Actions.SEARCH, this._searchChanged);
        App.Dispatcher.detach(App.Actions.TAB_CHANGED, this._searchTypeChanged);
    },
    /**
     *
     * @private
     */
    _searchTypeChanged: function (data) {
        this.setState({searchFor: data.tab});
    },
    /**
     *
     * @private
     */
    _inputChanged: function (e) {
        var $i = $(ReactDOM.findDOMNode(this)).find('i');
        var value = e.currentTarget.value;
        if (!value.length) {
            $i.show();
            return;
        }
        else {
            $i.hide();
            this.loadDataFromServer(value)
        }
    },
    /**
     *
     */
    _searchChanged: function (data) {
        //this.setState({searchResults: data.results});
    },
    /**
     *
     */
    render: function () {
        return (
            <span className="SearchContainer">
                <i className="ti-search"></i>
                <input/>
            </span>
        );
    },
});
