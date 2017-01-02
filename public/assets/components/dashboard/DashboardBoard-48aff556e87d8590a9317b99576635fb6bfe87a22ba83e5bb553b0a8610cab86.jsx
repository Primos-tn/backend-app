// app/assets/javascripts/components/article.js.jsx
var DashboardBoard = React.createClass({
    /**
     *
     */
    loadDataFromServer: function () {

    },
    /**
     *
     */
    componentDidMount () {
        if (this.props.id) {
            alert(this.props.id);
        }
        console.log(this.props);
    },
    /**
     *
     */
    componentWillUnmount () {

    },
    /**
     *
     */
    getInitialState () {
        return {items: []};
    },
    /**
     *
     */
    render: function () {
        return (
            <div>
                <DashboardBoardSmallWidgetsBlock/>
                <DashboardBoardUsersBlock/>
                <div className="card">
                    <div className="header">
                        <h4 className="title">{i18n.Shops}</h4>
                        <p className="category">24 Hours performance</p>

                    </div>
                    <div className="content">
                        <DashboardStoresMapView stores={this.props.stores}/>
                    </div>
                </div>
                <div className="row">
                    <DashboardBoardHeatMap/>
                    <DashboardBoardSales/>
                </div>
            </div>
        )
    },
});
