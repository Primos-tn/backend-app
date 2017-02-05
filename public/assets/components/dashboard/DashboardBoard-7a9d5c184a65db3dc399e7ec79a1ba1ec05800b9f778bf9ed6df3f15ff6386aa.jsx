// app/assets/javascripts/components/article.js.jsx
var DashboardBoard = React.createClass({
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
                <DashboardBoardSmallWidgetsBlock id={this.props.id}/>
                <DashboardBoardUsersBlock id={this.props.id}/>
                <div className="card">
                    <div className="header">
                        <h4 className="title">{i18n.Locations}</h4>
                    </div>
                    <div className="content">
                        <DashboardStoresMapView stores={this.props.stores} id={this.props.id}/>
                    </div>
                </div>
                <div className="row">
                    <DashboardBoardHeatMap id={this.props.id}/>
                    <DashboardBoardSales id={this.props.id}/>
                </div>
            </div>
        )
    }
});
