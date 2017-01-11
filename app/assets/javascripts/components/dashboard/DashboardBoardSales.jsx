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
        this._loadData()
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

        var sum = function (a, b) {
            return a + b
        };

        new Chartist.Pie('#chart_ages_block', data, {
            labelInterpolationFnc: function (value) {
                return Math.round(value / data.series.reduce(sum) * 100) + '%';
            }
        });
        let $legend = $('.chart-legend');
        let colors = '#68B3C8,#F3BB45,#EB5E28'.split(',');
        //
        data.series.forEach(function (entry, index) {
            $legend.append($('<span class="ChartLabel"></span>').html(entry).css({'color': colors[index]}));
        });
        /*
         ( text-info"></span>) {i18n['Age partition']}
         <span className="ChartLabel text-danger"></span> {i18n['Age partition']}
         <span className="ChartLabel text-warning"></span> {i18n['Age partition']}
         ;
         */

    },
    /**
     *
     */
    render: function () {
        return (
            <div className="col-md-6">
                <div className="card">
                    <div className="header">
                        <h4 className="title">{i18n['Age partition']}</h4>
                        <p className="category">{i18n['Age partition sub']}</p>
                    </div>
                    <div className="content">
                        <div id="chart_ages_block" className="ct-chart ct-perfect-fourth"></div>
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
    },
});
