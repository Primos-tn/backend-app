//
var StoresEdit = React.createClass({
    /**
     */
    componentDidMount: function () {
        // pla-ce center at the props
        // TODO fix empty initial position
        var latitude = this.props.latitude || 51.505;
        var longitude = this.props.longitude || -0.09;
        // init app in the store place if exists
        this._initMap(latitude, longitude);
        // if not exists
        this._setStorePosition(latitude, longitude);

    },
    /**
     *
     * @private
     */
    _loadInitialGeoPosition: function () {
        $.get(App.Routes.geoMine, function (position) {
            this._setStorePosition(position.latitude, position.longitude)
        }.bind(this));
    },

    /**
     * @param {L.latLng} latLng
     * @private
     */
    _loadPositionFullAddress: function (latLng) {
        let latitude = latLng.lat;
        let longitude = latLng.lng;
        $('#store_latitude').val(latitude);
        $('#store_longitude').val(longitude);
        $.get(App.Helpers.formatApiUrl(App.Routes.geoAddress, {}, {
            latitude: latitude,
            longitude: longitude
        }), this._fillAddress);
    },

    /**
     *
     * @private
     */
    _fillAddress: function (AddressObject) {
        var address = AddressObject.address;
        if (address != 'null') {
            address = address.split(',');
            if (address.length > 2) {
                let $address = $('#store_address') ;
                if (address[0].indexOf('Unnamed Road') < 0) {
                    // empty it
                    $address.val('');
                    $address.val(address[0]);
                }
                //
                var $country = $('#store_country_code');
                var countryCode = $country.find('option:contains("' + address [2].trim() + '")').val();
                if (countryCode) {
                    console.log(countryCode);
                    $country.val(countryCode);
                }
                let cityDetails = address[1].trim().split(" ");
                let $city = $('#store_city');
                if (cityDetails.length > 0 ) {
                    // FIXME france
                    $city.val(cityDetails[1]);
                    cityDetails.pop() ;
                    $address.val([cityDetails.join(" ") , $address.val()].join(', '));
                }
                else {
                    $city.val(address[1]);
                }

            }
        }
    },
    /**
     *
     * @param lat
     * @param lng
     * @private
     */
    _initMap(lat, lng){
        var dom = ReactDOM.findDOMNode(this);
        var $map = $(dom).find('#map');
        var map = L.map($map[0]).setView([lat, lng], 13);
        L.tileLayer(App.Configuration.MAP_TILES_URL, {
            attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);
        this._map = map;
    },
    /**
     *
     * @param lat
     * @param lng
     * @private
     */
    _setStorePosition(lat, lng){
        $('body').addClass('map');
        var marker = new L.Marker([lat, lng], {draggable: true}).addTo(this._map);
        marker.on('dragend', function (event) {
            this._loadPositionFullAddress(event.target.getLatLng());
        }.bind(this));
    },
    /**
     *
     * @private
     */
    _onMarkerMoved: function () {

    },
    /**
     */
    componentWillUnmount: function () {

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
