let MAP_ID = 'users_map';
var DashboardUsersViewMenu = React.createClass({
    /**
     *
     */
    render: function () {
        return (
            <div className="btn-group btn-group-sm">
                <button className="btn"><span className="ti-alarm-clock"></span></button>
                <button className="btn"><span className="ti-alarm-clock"></span></button>
                <button className="btn"><span className="ti-alarm-clock"></span></button>
            </div>

        );
    }
});

/**
 *
 */
var DashboardUsersView = React.createClass({
    /**
     */
    componentDidMount: function () {
        if (this.props.fullHeight) {
            $('#' + MAP_ID).css({'height': $('.DashboardMainContainer').height()});
        }
        var map = L.map(MAP_ID).setView([51.505, -0.09], 3);
        L.tileLayer(App.Configuration.MAP_TILES_URL, {
            attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map)

        /**
         * Check for stores
         */
        if (this.props.stores) {
            this.props.stores.forEach(function (entry) {
                var latitude = entry.latitude;
                var longitude = entry.longitude;
                if (latitude && longitude) {
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
                <div id={MAP_ID}>
                </div>
            </div>

        );
    }
});
