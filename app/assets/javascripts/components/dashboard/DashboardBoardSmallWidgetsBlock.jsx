// app/assets/javascripts/components/article.js.jsx
var DashboardBoardSmallWidgetsBlock = React.createClass({
    /**
     *
     */
    getInitialState (){
        return {
            followers_count: null,
            views_count: null,
            interested_count: null,
            similar_count: null
        };
    },
    /**
     *
     */
    componentDidMount () {
        this._loadData();
    },
    /**
     *
     */
    componentWillUnmount: function () {

    },
    /**
     *
     */
    _loadData() {
        let url = App.DashboradRoutes.stats;
        if (this.props.id) {
            url += '?product_id=' + this.props.id;
        }
        $.get(url, this._displayStats)
    },
    /**
     *
     */
    _displayStats(data) {
        this.setState({
            followers_count: data.followers_count,
            views_count: data.views_count,
            products_count: data.products_count,
            stores_count: data.stores_count
        })

    },
    /**
     *
     */
    render: function () {
        let state = this.state;
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
                                        {state.products_count}
                                    </div>
                                </div>
                            </div>
                            <div className="footer">
                                <hr />
                                <div className="stats">
                                    <i className="ti-reload"></i> {i18n['Updated recently']}
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
                                        <p>{i18n.Shops}</p>
                                        {state.stores_count}
                                    </div>
                                </div>
                            </div>
                            <div className="footer">
                                <hr />
                                <div className="stats">
                                    <i className="ti-calendar"></i> {i18n['Updated recently']}
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
                                        <p>{i18n.Reviews}</p>
                                        {state.interested_count}
                                    </div>
                                </div>
                            </div>
                            <div className="footer">
                                <hr />
                                <div className="stats">
                                    <i className="ti-timer"></i>{i18n['Updated recently']}
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
                                        <i className="ti-user"></i>
                                    </div>
                                </div>
                                <div className="col-xs-7">
                                    <div className="numbers">
                                        <p>{i18n.Followers}</p>
                                        {state.followers_count}
                                    </div>
                                </div>
                            </div>
                            <div className="footer">
                                <hr />
                                <div className="stats">
                                    <i className="ti-reload"></i>{i18n['Updated recently']}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        )
    },
});
