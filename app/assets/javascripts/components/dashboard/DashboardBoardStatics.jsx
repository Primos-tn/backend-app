// app/assets/javascripts/components/article.js.jsx
var DashboardBoardStaticsBlock = React.createClass({
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
                <div className="col-lg-3 col-sm-6">
                    <div className="card">
                        <div className="content">
                            <div className="row">
                                <div className="col-xs-5">
                                    <div className="icon-big icon-warning text-center">
                                        <i className="ti-server"></i>
                                    </div>
                                </div>
                                <div className="col-xs-7">
                                    <div className="numbers">
                                        <p>{i18n.Products}</p>
                                        105GB
                                    </div>
                                </div>
                            </div>
                            <div className="footer">
                                <hr />
                                <div className="stats">
                                    <i className="ti-reload"></i> Updated now
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div className="col-lg-3 col-sm-6">
                    <div className="card">
                        <div className="content">
                            <div className="row">
                                <div className="col-xs-5">
                                    <div className="icon-big icon-success text-center">
                                        <i className="ti-wallet"></i>
                                    </div>
                                </div>
                                <div className="col-xs-7">
                                    <div className="numbers">
                                        <p>{i18n.Incoming}</p>
                                        $1,345
                                    </div>
                                </div>
                            </div>
                            <div className="footer">
                                <hr />
                                <div className="stats">
                                    <i className="ti-calendar"></i> Last day
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div className="col-lg-3 col-sm-6">
                    <div className="card">
                        <div className="content">
                            <div className="row">
                                <div className="col-xs-5">
                                    <div className="icon-big icon-danger text-center">
                                        <i className="ti-pulse"></i>
                                    </div>
                                </div>
                                <div className="col-xs-7">
                                    <div className="numbers">
                                        <p>{i18n.Interested}</p>
                                        23
                                    </div>
                                </div>
                            </div>
                            <div className="footer">
                                <hr />
                                <div className="stats">
                                    <i className="ti-timer"></i> In the last hour
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div className="col-lg-3 col-sm-6">
                    <div className="card">
                        <div className="content">
                            <div className="row">
                                <div className="col-xs-5">
                                    <div className="icon-big icon-info text-center">
                                        <i className="ti-twitter-alt"></i>
                                    </div>
                                </div>
                                <div className="col-xs-7">
                                    <div className="numbers">
                                        <p>{i18n.Followers}</p>
                                        +42
                                    </div>
                                </div>
                            </div>
                            <div className="footer">
                                <hr />
                                <div className="stats">
                                    <i className="ti-reload"></i> Updated now
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        )
    },
});
