

var BrandProfileStoresInfo = React.createClass({

    /**
     *
     */
    componentDidMount: function () {
        App.Dispatcher.attach(App.Actions.BRAND_LOCATIONS_FETCHING, this.onLocationsLoaded);
        this._fetchItems();
    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(App.Actions.BRAND_LOCATIONS_FETCHING, this.onLocationsLoaded);
    },
    /**
     *
     * @param response
     */
    onLocationsLoaded : function (response){
        this.refs.map.addMarkers(response.stores);
    },
    /**
     *
     */
    _fetchItems: function () {
        this.setState({isFetchingItems: true});
        App.Stores.loadData({
            url: App.Routes.brandLocations,
            params : {id : this.props.brandId},
            action: App.Actions.BRAND_LOCATIONS_FETCHING
        });
    },
    /**
     *
     */
    getMarkerIconStyle (entry){
        console.log(entry);
        let html = '<img src="' + App.Helpers.getMediaUrl(entry.picture.small_thumb.url) + '">';
        //console.log(this.props.brand.picture);
        return L.divIcon({className: 'DashboardStores__Marker', html: html})
    },
    /**
     *
     */
    render: function () {
        return (
            <div>
                <Map ref="map" positions={this.props.positions} getMarkerIconStyle={this.getMarkerIconStyle}/>
            </div>
        )
    }
});
