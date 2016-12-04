// app/assets/javascripts/components/article.js.jsx
var DashboardBoardHooks = React.createClass({
    /**
     *
     */
    loadDataFromServer: function () {

    },
    /**
     *
     */
    componentDidMount: function () {

    },
    /**
     *
     */
    componentWillUnmount: function () {

    },
    /**
     *
     */
    getInitialState: function () {
        return {items: []};
    },
    /**
     *
     */
    render: function () {
        return (
                <div className="col-md-6">
                    <div className="card">
                        <div className="header">
                            <h4 className="title">Email Statistics</h4>
                            <p className="category">Last Campaign Performance</p>
                        </div>
                        <div className="content">
                            <div id="chartPreferences" className="ct-chart ct-perfect-fourth"></div>
                            <hr/>
                            <div className="footer">
                                <div className="chart-legend">
                                    <i className="fa fa-circle text-info"></i> Open
                                    <i className="fa fa-circle text-danger"></i> Bounce
                                    <i className="fa fa-circle text-warning"></i> Unsubscribe
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
