// app/assets/javascripts/components/article.js.jsx
var DashboardBoardHeatMap = React.createClass({
    /**
     */
    componentDidMount: function () {
        var dom = ReactDOM.findDOMNode(this);
        var $map = $(dom).find('#map');
        var map = L.map($map[0]).setView([51.505, -0.09], 13);
        L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);
        //$('body').addClass('map');
        this._map = map;
        //
        /*
        L.heatLayer([
            [50.5, 30.5, 0.2], // lat, lng, intensity
            [50.6, 30.4, 0.5]
        ], {radius: 25}).addTo(map);
        */
    },
    /**
     *
     * @private
     */
    _placeMarkers: function () {
        /*
         this.props.positions.forEach(function (entry) {
         console.log(entry);
         L.marker(entry, {
         icon: L.divIcon({
         html: '<div class="pin"></div>\
         <div class="pulse"></div>'
         })
         }).addTo(this._map);
         }.bind(this));*/

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
            <div className="col-md-6">
                <div className="card">
                    <div className="header">
                        <h4 className="title">{i18n['HeatMap']}</h4>
                        <p className="category">{i18n['HeatMap']}</p>
                    </div>
                    <div className="content">
                        <div className="MapContainer">
                            <div id="map">
                            </div>
                        </div>
                        <hr/>
                        <div className="footer">
                            <div className="chart-legend text-danger">

                            </div>
                            <div className="stats">
                                <i className="ti-timer"></i> Campaign sent 2 days ago
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        )
    }
});
