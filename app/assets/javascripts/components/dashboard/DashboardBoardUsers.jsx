// app/assets/javascripts/components/article.js.jsx
var DashboardBoardUsersBlock = React.createClass({

    /**
     *
     */
    getInitialState (){
        return {items: []};
    },
    /**
     *
     */
    componentDidMount () {
        this._loadDataFromServer();
    },
    /**
     *
     */
    componentWillUnmount () {

    },
    /**
     *
     */
    _loadDataFromServer() {
        // after data loaded from server
        this._dataLoaded()
    },
    /**
     *
     * @private
     */
    _dataLoaded (){
        var dataSales = {
            labels: ['9:00AM', '12:00AM', '3:00PM', '6:00PM', '9:00PM', '12:00PM', '3:00AM', '6:00AM'],
            series: [
                [287, 385, 490, 562, 594, 626, 698, 895, 952],
                [67, 152, 193, 240, 387, 435, 535, 642, 744],
                [23, 113, 67, 108, 190, 239, 307, 410, 410]
            ]
        };

        var optionsSales = {
            lineSmooth: false,
            low: 0,
            high: 1000,
            showArea: true,
            height: "245px",
            axisX: {
                showGrid: false,
            },
            lineSmooth: Chartist.Interpolation.simple({
                divisor: 3
            }),
            showLine: true,
            showPoint: false,
        };

        var responsiveSales = [
            ['screen and (max-width: 640px)', {
                axisX: {
                    labelInterpolationFnc: function (value) {
                        return value[0];
                    }
                }
            }]
        ];

        Chartist.Line('#chartHours', dataSales, optionsSales, responsiveSales);
    },
    /**
     *
     */
    render () {
        return (
            <div className="row">
                <div className="col-md-12">
                    <div className="card">
                        <div className="header">
                            <h4 className="title">{i18n['Users behavior']}</h4>
                            <p className="category">24 Hours performance</p>
                        </div>
                        <div className="content">
                            <div id="chartHours" className="ct-chart"></div>
                            <div className="footer">
                                <div className="chart-legend">
                                    <span className="ChartLabel text-info"></span> Open
                                    <span className="ChartLabel  text-danger"></span> Click
                                    <span className="ChartLabel  text-warning"></span> Click Second Time
                                </div>
                                <hr/>
                                    <div className="stats">
                                        <i className="ti-reload"></i> Updated 3 minutes ago
                                    </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        )
    },
});
