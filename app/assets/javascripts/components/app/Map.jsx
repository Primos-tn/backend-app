//
var Map = React.createClass({
    // getMarkerIconStyle
    // onMapAreaChanged

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
        var position = store.get(App.Constants.USER_MAP_LAST_CENTER) || [51.505, -0.09] ;
        var zoom = store.get(App.Constants.USER_MAP_LAST_ZOOM) || 5 ;

        var map = L.map('map').setView(position, zoom);

        L.tileLayer(App.Configuration.MAP_TILES_URL, {
            attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);
        this._map = map;
        this._placeMarkers();
        if (this.props.onMapAreaChanged) {
            let changed = this.props.onMapAreaChanged;
            let circle = L.circle(map.getCenter(), 25 * 1000).addTo(map);
            let fireChange = function (e) {
                changed(e.target);
                circle.setLatLng(e.target.getCenter());
                store.set(App.Constants.USER_MAP_LAST_CENTER, e.target.getCenter())
                store.set(App.Constants.USER_MAP_LAST_ZOOM, e.target.getZoom())
                //changed(map.getCenter(), map.getCenter().distanceTo(map.getBounds().getSouthWest()));
            };

            map.on('zoomend', fireChange);
            map.on('dragend', fireChange);
        }
        if (this.props.onMapReady) {
            this.props.onMapReady(map)
        }
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
    _placeMarkers: function (positions) {
        positions = positions || this.props.positions;
        let parsedPosition;
        let parsedPositions = [];
        let defaultIcon = L.divIcon({
            html: '<div class="pin"></div>\
            <div class="pulse"></div>'
        });
        let icon;
        // getIconStyle
        if (positions) {
            positions.forEach(function (entry) {
                if (this.props.getMarkerIconStyle) {
                    icon = this.props.getMarkerIconStyle(entry);
                }
                else {
                    icon = defaultIcon
                }
                parsedPosition = App.Helpers.parsePosition(entry);
                parsedPositions.push(parsedPosition);
                L.marker(parsedPosition, {
                    icon: icon
                }).addTo(this._map);
            }.bind(this));
            this._map.setView(this._calculateCentroid(parsedPositions))
        }
    },
    /**
     *
     * @param positions
     */
    addMarkers (positions){
        this._placeMarkers(positions)
    },
    /**
     *
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
