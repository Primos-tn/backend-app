//
var Map = React.createClass({
    /**
     *
     */
    getInitialState: function () {
        return {searchResults: [], searchFor: 'products'};
    },
    /**
     */
    componentDidMount: function () {
        App.Dispatcher.attach(App.Actions.SEARCH, this._searchChanged);
        App.Dispatcher.attach(App.Actions.TAB_CHANGED, this._searchTypeChanged);
        var $map = $('#map');
        var $main = $('main');
        var top = $map.offset().top;
        $main.css('paddingBottom', '0px');
        if (this.props.height) {
            $map.css('height', this.props.height);
        }
        else {
            $map.css('height', $(window).height() - top);
            $('body').addClass('map');
        }
        var map = L.map('map').setView([51.505, -0.09], 5);

        L.tileLayer(App.Configuration.MAP_TILES_URL, {
            attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);
        this._map = map;
        this._placeMarkers();
        if (this.props.onMapAreaChanged) {
            this._map.on('moveend', function (e){
                this.props.onMapAreaChanged(e.target.getBounds().toBBoxString())
            }.bind(this));
        }

    },
    /**
     *
     * @param entry
     * @returns {*}
     * @private
     */
    _parsePosition  (entry){
        var position = entry.position || entry;
        if (position.latitude) {
            position = [position.latitude, position.longitude]
        }
        return position;
    },
    /**
     *
     * @private
     */
    _calculateCentroid (positions){
        var xSum = 0, ySum = 0, len = 0;
        positions.forEach(function (entry) {
            xSum += entry[0];
            ySum += entry[1];
            len++;
        }, true);
        return [xSum / len, ySum / len];
    },
    /**
     *
     * @private
     */
    _placeMarkers: function () {
        let positions = this.props.positions;
        let parsedPosition;
        let parsedPositions = [];
        if (positions) {
            positions.forEach(function (entry) {
                parsedPosition = this._parsePosition(entry) ;
                parsedPositions.push(parsedPosition);
                L.marker(parsedPosition, {
                    icon: L.divIcon({
                        html: '<div class="pin"></div>\
            <div class="pulse"></div>'
                    })
                }).addTo(this._map);
            }.bind(this));
            this._map.setView(this._calculateCentroid(parsedPositions))
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
                <div id="map">
                </div>
            </div>
        );
    }
});
