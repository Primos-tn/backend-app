/**
 *
 */
var MapView = React.createClass({
    /**
     *
     */
    getInitialState: function () {
        let tomorrow = App.Helpers.getTomorrow();
        return {
            map: null,
            offers: [],
            serverLoadingDone: false,
            filterShow: false,
            tomorrow: tomorrow.getTime(),
            categoriesList: [],
            range: [],
            locations: []


        };
    },
    /**
     *
     */
    actions: {
        productsList: "PRODUCTS_LIST",
        locationsList: "LOCATIONS_LIST",

    },

    /**
     *
     */
    componentDidMount () {
        setTimeout(function () {
            this.countDown();
        }.bind(this), 1000);
        App.Dispatcher.attach(this.actions.productsList, this.onProductsChange);
        App.Dispatcher.attach(this.actions.locationsList, this.onLocationsLoaded);
        //App.Dispatcher.attach(App.Actions.FILTER_CHANGED, this.filterChanged);
    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(this.actions.productsList, this.onProductsChange);
        App.Dispatcher.detach(this.actions.locationsList, this.onLocationsLoaded);
        //App.Dispatcher.detach(App.actions.FILTER_CHANGED, this.filterChanged);
        $('.MapFilterContainer').draggable();
    },
    /**
     *
     * @param dir
     */
    countDown(dir){
        let diff = this.state.tomorrow - Date.now();
        let hours = 0;
        let minutes = 0;
        if (diff > 0) {
            hours = Math.floor((diff % 86400000) / 3600000);
            minutes = Math.round(((diff % 86400000) % 3600000) / 60000);
            $('.MapCounter').html([hours, minutes].join(':'));
            // recursive call
            setTimeout(function () {
                this.countDown();
            }.bind(this), 60000);
        }
    },
    /**
     *
     */
    getServerItems () {
        // get query
        let query = $.extend({
                brands: this.props.brand
            }, {categoriesList: this.state.categoriesList},
            {range: this.state.range},
            {map: this.state.map});
        console.log(query);
        App.Stores.loadData({
            url: App.Routes.products,
            action: this.actions.productsList,
            query: query
        });
    },

    /**
     *
     */
    loadStores () {
        App.Stores.loadData({
            url: App.Routes.brands,
            action: this.actions.locationsList,
            query: {map: this.state.map, exclude_today: true}
        });
    },
    /**
     *
     */
    onMapReady (map){
        console.log('map ready');
        this._setMapParams(map, true);
        this.storesMarkers = new L.MarkerClusterGroup({
            iconCreateFunction: function (cluster) {
                return L.divIcon({
                    html: '<div class="marker-store"> \
                    <div class="">' + cluster.getChildCount() + '</div>\
                    </div>'
                });
            }
        });
        map.addLayer(this.storesMarkers);
    },
    /**
     *
     * @param map
     * @param firsLoad only for first time
     * @returns {{center: *, distance: *}}
     * @private
     */
    _setMapParams (map, firsLoad){
        let center = map.getCenter();
        var eastBound = map.getBounds().getEast();
        var centerEast = L.latLng(center.lat, eastBound);
        var dist = center.distanceTo(centerEast);
        this.setState({
            map: {
                center: [center.lat, center.lng],
                distance: dist / 2
            }
        }, function () {
            if (firsLoad) {
                this.getServerItems();
                alert('load');
                this.loadStores();
            }
        }.bind(this));
    },
    /**
     *
     * @param map
     */
    onMapAreaChanged(map){
        this._setMapParams(map);
        this.loadStores();
        this.getServerItems();
    },
    /**
     *
     * @param categoriesList
     */
    onCategoriesSelected (categoriesList){
        this.setState({categoriesList: categoriesList});
        this.getServerItems();
    },
    /**
     *
     */
    onSliderChanged (range, ui){
        this.setState({range: ui.values});
        this.getServerItems();
    },
    /**
     *
     */
    toggleFilter: function () {
        this.setState({filterShow: !this.state.filterShow})
    },
    /**
     *
     */
    onProductsChange: function (result) {
        this.setState({offers: result.products, serverLoadingDone: true}, function () {

        });
    },

    /**
     *
     */
    onLocationsLoaded: function (result) {
        let brands = result.brands;
        let positions = [];
        brands.forEach(function (entry) {
            entry.stores.forEach(function (store) {
                console.log(store);
                positions.push(new L.Marker(App.Helpers.parsePosition(store)));
            });
        });
        // console.log(positions);
        this.storesMarkers.addLayers(positions);
    },
    /**
     *
     */
    render: function () {
        return (
            <div>
                <div className="MapFilterContainer" style={{'display' : this.state.filterShow ? 'block' : 'none'}}>
                    <div className="MapFilterContainer__Inner">
                        <span className="MapFilterContainer__closer ti-close" onClick={this.toggleFilter}></span>

                        <CategoriesList onCategoriesSelected={this.onCategoriesSelected} type="Product"/>
                        <RangeSlider onSliderChanged={this.onSliderChanged}/>
                    </div>
                </div>
                <div className="MapFilterShow" onClick={this.toggleFilter}
                     style={{'display' : this.state.filterShow ? 'none' : ''}}>
                    <span className="ti-filter"></span>
                </div>
                <div className="MapCounter">

                </div>
                <Map onMapAreaChanged={this.onMapAreaChanged} onMapReady={this.onMapReady}></Map>
            </div>
        )
    }
});
