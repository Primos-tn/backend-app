// app/assets/javascripts/components/article.js.jsx
var DashboardBoardSales = React.createClass({

    /**
     *
     */
    getInitialState: function () {
        return {items: []};
    },
    /**
     *
     */
    componentDidMount: function () {
        this._loadDataFromServer()
    },
    /**
     *
     */
    componentWillUnmount: function () {

    },

    /**
     *
     */
    _loadDataFromServer () {
        this._draw()
    },
    /**
     *
     */
    _draw () {
        var data = {
            series: [5, 3, 4]
        };

        var sum = function(a, b) { return a + b };

        new Chartist.Pie('#chart_sales_block', data, {
            labelInterpolationFnc: function(value) {
                return Math.round(value / data.series.reduce(sum) * 100) + '%';
            }
        });
    },
    /**
     *
     */
    render: function () {
        return (
                <div className="col-md-6">
                    <div className="card">
                        <div className="header">
                            <h4 className="title">Sails Statistics</h4>
                            <p className="category">Last Campaign Performance</p>
                        </div>
                        <div className="content">
                            <div id="chart_sales_block" className="ct-chart ct-perfect-fourth"></div>
                            <hr/>
                            <div className="footer">
                                <div className="chart-legend">
                                    <span className="ChartLabel text-info"></span> Open
                                    <span className="ChartLabel text-danger"></span> Bounce
                                    <span className="ChartLabel text-warning"></span> Unsubscribe
                                </div>
                                <div className="stats">
                                    <i className="ti-timer"></i> Campaign sent 2 days ago
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        )
    },
});
