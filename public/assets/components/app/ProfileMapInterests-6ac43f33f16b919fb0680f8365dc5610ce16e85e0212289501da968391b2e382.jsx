/**
 *
 */
var ProfileMapInterests = React.createClass({
    getInitialState(){

        let regionInterest = {};
        try {
            regionInterest = JSON.parse(this.props.regionInterest);
        }
        catch (e){

        }
        // my be null for first open
        if(!regionInterest){
            regionInterest = {};
        }
        return {
            center: regionInterest.center || [51.505, -0.09],
            distance: regionInterest.distance || 40
        }
    },
    //
    _updateRegionCenter (center){
        // get form
        this.setState({'center': center})

    },
    _updateRegionDistance (distance){
        this.setState({'distance': distance})

    },
    /**
     *
     */
    componentDidMount: function () {
        //
        let center = this.state.center;
        // set default to 40 km
        let distance = this.state.distance;

        var map = L.map('map').setView(center, 9);

        L.tileLayer(App.Configuration.MAP_TILES_URL, {
            attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);
        let circle = L.circle(center, distance * 1000);
        circle.on('mousedown', event => {
            //L.DomEvent.stop(event);
            map.dragging.disable();
            let {lat: circleStartingLat, lng: circleStartingLng} = circle._latlng;
            let {lat: mouseStartingLat, lng: mouseStartingLng} = event.latlng;

            map.on('mousemove', event => {
                let {lat: mouseNewLat, lng: mouseNewLng} = event.latlng;
                let latDifference = mouseStartingLat - mouseNewLat;
                let lngDifference = mouseStartingLng - mouseNewLng;
                let center = [circleStartingLat - latDifference, circleStartingLng - lngDifference];
                circle.setLatLng(center);
                this._updateRegionCenter(center);
            });
        });

        map.on('mouseup', () => {
            map.dragging.enable();
            map.removeEventListener('mousemove');
        });
        circle.addTo(map);
        let $slider = $("#profile_region_interest_distance_slider");
        let $indicator = $("#profile_region_interest_distance_slider_indicator");
        let $spanText = $indicator.find('span') ;
        let initialValue = distance;
        let min = 40;
        let max = 160;

        let _updateDistanceIndicator = (value) => {
            $indicator.css("margin-left", (value - min) / (max - min) * 100 + "%");
            $indicator.css("left", "-60px");
            $spanText.html(value + ' Km')
        };
        $slider.slider({
            value: initialValue,
            min: min,
            max: max,
            slide: (event, ui) => {
                let value = ui.value;
                circle.setRadius(value * 1000);
                _updateDistanceIndicator(value);
                this._updateRegionDistance(value);
            }
        });
        _updateDistanceIndicator(distance);
    },
    /**
     *
     */
    componentWillUnmount: function () {

    },
    /**
     *
     */
    render: function () {
        return (
            <div>
                <input type="hidden" name="profile[region_interest]" value={JSON.stringify(this.state)}/>
                <div id="map" className="UserProfile__InterestRegionMap">
                </div>
            </div>
        );
    }
});
