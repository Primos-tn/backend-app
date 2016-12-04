// app/assets/javascripts/components/article.js.jsx
var DashboardBoardUsersBlock = React.createClass({
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
                                    <i className="fa fa-circle text-info"></i> Open
                                    <i className="fa fa-circle text-danger"></i> Click
                                    <i className="fa fa-circle text-warning"></i> Click Second Time
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
