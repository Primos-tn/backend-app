// app/assets/javascripts/components/article.js.jsx
var DashboardBoardHeatMap = React.createClass({
    /**
     */
    componentDidMount: function () {
        new Chartist.Bar('#chart_search_block', {
            labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
            series: [
                [5, 4, 3, 7, 5, 10, 3],
                [3, 2, 9, 5, 4, 6, 4]
            ]
        }, {
            seriesBarDistance: 10,
            reverseData: true,
            horizontalBars: true,
            axisY: {
                offset: 70
            }
        });
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
                        <h4 className="title">{i18n['UsersOrientation']}</h4>
                    </div>
                    <div className="content">
                        <div id="chart_search_block" className="ct-chart ct-perfect-fourth"></div>
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
