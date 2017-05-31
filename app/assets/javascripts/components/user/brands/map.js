/**
 *
 * @constructor
 */
function MapList(options) {
    this.init();
    options = options || {};
    this.options = options;
    this.listName = options.listName || 'brands';
    this.markerIcon = options.icon;
};
function getMapOptions() {
    var center = App.Helpers.getUserPosition().map.center;
    return {
        zoom: 4,
        center: new google.maps.LatLng(center[0], center[1]),
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        mapTypeControl: false,
        mapTypeControlOptions: {
            style: google.maps.MapTypeControlStyle.DROPDOWN_MENU,
            position: google.maps.ControlPosition.LEFT_CENTER
        },
        panControl: false,
        panControlOptions: {
            position: google.maps.ControlPosition.TOP_RIGHT
        },
        zoomControl: true,
        zoomControlOptions: {
            style: google.maps.ZoomControlStyle.LARGE,
            position: google.maps.ControlPosition.TOP_LEFT
        },
        scrollwheel: false,
        scaleControl: false,
        scaleControlOptions: {
            position: google.maps.ControlPosition.TOP_LEFT
        },
        streetViewControl: true,
        streetViewControlOptions: {
            position: google.maps.ControlPosition.LEFT_TOP
        },
        styles: [
            {
                "featureType": "landscape",
                "stylers": [
                    {
                        "hue": "#FFBB00"
                    },
                    {
                        "saturation": 43.400000000000006
                    },
                    {
                        "lightness": 37.599999999999994
                    },
                    {
                        "gamma": 1
                    }
                ]
            },
            {
                "featureType": "road.highway",
                "stylers": [
                    {
                        "hue": "#FFC200"
                    },
                    {
                        "saturation": -61.8
                    },
                    {
                        "lightness": 45.599999999999994
                    },
                    {
                        "gamma": 1
                    }
                ]
            },
            {
                "featureType": "road.arterial",
                "stylers": [
                    {
                        "hue": "#FF0300"
                    },
                    {
                        "saturation": -100
                    },
                    {
                        "lightness": 51.19999999999999
                    },
                    {
                        "gamma": 1
                    }
                ]
            },
            {
                "featureType": "road.local",
                "stylers": [
                    {
                        "hue": "#FF0300"
                    },
                    {
                        "saturation": -100
                    },
                    {
                        "lightness": 52
                    },
                    {
                        "gamma": 1
                    }
                ]
            },
            {
                "featureType": "water",
                "stylers": [
                    {
                        "hue": "#0078FF"
                    },
                    {
                        "saturation": -13.200000000000003
                    },
                    {
                        "lightness": 2.4000000000000057
                    },
                    {
                        "gamma": 1
                    }
                ]
            },
            {
                "featureType": "poi",
                "stylers": [
                    {
                        "hue": "#00FF6A"
                    },
                    {
                        "saturation": -1.0989010989011234
                    },
                    {
                        "lightness": 11.200000000000017
                    },
                    {
                        "gamma": 1
                    }
                ]
            }
        ]
    }
};
/**
 *
 * @type {{init: MapList.init}}
 */
MapList.prototype = {
    /**
     *
     */
    init: function () {
        $('#collapseMap').on('shown.bs.collapse', function (e) {
            if (!this.mapReady) {
                this._initMap();
                this.mapReady = true;
            }
        }.bind(this));
    },
    /**
     *
     * @private
     */
    _initMap: function () {
        var mapObject = new google.maps.Map(document.getElementById('map'), getMapOptions());
        mapObject.addListener('idle', this.loadItems.bind(this));
        this._mapObject = mapObject;

    },
    /**
     *
     * @param brand
     * @param store
     * @returns {InfoBox}
     */
    getInfoBox: function (brand, store) {
        return new InfoBox({
            content: '<div class="marker_info" id="marker_info">' +
            '<img src="' + item.map_image_url + '" alt="Image"/>' +
            '<h3>' + brand.name + '</h3>' +
            '<span>' + item.description_point + '</span>' +
            '<div class="marker_tools">' +
            '<form action="http://maps.google.com/maps" method="get" target="_blank" style="display:inline-block""><input name="saddr" value="' + item.get_directions_start_address + '" type="hidden"><input type="hidden" name="daddr" value="' + item.location_latitude + ',' + item.location_longitude + '"><button type="submit" value="Get directions" class="btn_infobox_get_directions">Directions</button></form>' +
            '<a href="tel://' + brand.phone + '" class="btn_infobox_phone">' + item.phone + '</a>' +
            '</div>' +
            '<a href="' + brand.url_point + '" class="btn_infobox">Details</a>' +
            '</div>',
            disableAutoPan: false,
            maxWidth: 0,
            pixelOffset: new google.maps.Size(10, 125),
            closeBoxMargin: '5px -20px 2px 2px',
            closeBoxURL: "http://www.google.com/intl/en_us/mapfiles/close.gif",
            isHidden: false,
            alignBottom: true,
            pane: 'floatPane',
            enableEventPropagation: true
        });
    },
    /**
     *
     * @private
     */
    _placeMarkers: function (items) {
        var
            marker;
        var mapObject = this._mapObject;
        console.log(items);
        console.log(items);
        console.log(items);
        console.log(items);
        items.forEach(function (entry, index) {
            $(entry.stores).each(function (index, _entry) {
                console.log(App.Helpers.getMediaUrl(entry.cover.thumb.url));
                marker = new google.maps.Marker({
                    position: new google.maps.LatLng(_entry.lat, _entry.lng),
                    map: mapObject,
                    icon: App.Helpers.getMediaUrl(entry.cover.thumb.url)
                });
                marker.setMap(mapObject);
                google.maps.event.addListener(marker, 'click', (function () {
                    this.closeInfoBox();
                    this.getInfoBox(entry, _entry).open(mapObject, this);
                    mapObject.setCenter(new google.maps.LatLng(_entry.lat, _entry.lng));
                }.bind(this)));
            }).bind(this);
        }.bind(this));
    },
    /**
     *
     */
    closeInfoBox: function () {
        $('div.infoBox').remove();
    },
    /**
     *
     */
    loadItems: function () {
        $.get(this.options.url, this.options.query).then(function (data) {
            this._placeMarkers(data[this.listName]);
        }.bind(this));

    }
};