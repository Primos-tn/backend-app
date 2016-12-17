//
var Map = React.createClass({
    /**
     *
     */
    getInitialState: function () {
        return {searchResults: [], searchFor : 'products'};
    },
    /**
     *
     */
    loadDataFromServer: function (e) {
        var value = e.currentTarget.value ;
        if (!value.length){
            return;
        }
        App.Stores.loadData({
            url : [App.Routes.search, this.state.searchFor].join('/'),
            action: App.Actions.SEARCH,
            data : {query : value, searchType : App.Actions.AUTO_COMPLETE}
        });
    },

    /**
     */
    componentDidMount: function () {
        App.Dispatcher.attach(App.Actions.SEARCH, this._searchChanged);
        App.Dispatcher.attach(App.Actions.TAB_CHANGED, this._searchTypeChanged);
        var $map = $('#map') ;
        var $main = $('main') ;
        var top = $map.offset().top;
        $main.css('paddingBottom', '0px');
        $map.css('height', $(window).height() -top );
        var map = L.map('map').setView([51.505, -0.09], 13);

        L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);
        $('body').addClass('map');
        this._map = map ;
        this._placeMarkers();

    },
    /**
     *
     * @private
     */
    _placeMarkers : function (){
        if (this.props.positions){

            this.props.positions.forEach(function (entry){
                console.log(entry);
                L.marker(entry, {icon : L.divIcon({
                    html : '<div class="pin"></div>\
            <div class="pulse"></div>'
                })}).addTo(this._map);
            }.bind(this));
        }

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
    _searchTypeChanged : function (data){
        this.setState({searchFor : data.tab});
    },
    /**
     *
     */
    _searchChanged: function (data) {
        this.setState({searchResults: data.results});
    },
    /**
     *
     */
    render: function () {
        return (
            <div className="MapContainer">
                <div id="map">
                </div>

            </div>
        );
    },
});