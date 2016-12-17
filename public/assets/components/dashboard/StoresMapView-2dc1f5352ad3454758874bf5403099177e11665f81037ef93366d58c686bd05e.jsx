//
var StoresMapView = React.createClass({
    /**
     */
    componentDidMount: function () {
        if (this.props.minHeight) {
            $('#map_stores').css({'height': this.props.minHeight});
        }
        var map = L.map('map_stores').setView([51.505, -0.09], 3);
        L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);
        /**
         * Check for stores
         */
        if (this.props.stores){
            this.props.stores.forEach(function (entry){
                var latitude = entry.latitude ;
                var longitude =  entry.longitude;
                if (latitude && longitude){
                    new L.Marker([latitude, longitude]).addTo(map);
                }
            })
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
    _searchTypeChanged: function (data) {
        this.setState({searchFor: data.tab});
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

                <div id="map_stores">
                </div>
            </div>

        );
    }
});
