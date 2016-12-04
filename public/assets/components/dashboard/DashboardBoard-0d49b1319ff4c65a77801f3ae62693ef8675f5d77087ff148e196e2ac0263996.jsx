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
            <div>
                <DashboardBoardStaticsBlock/>
                <DashboardBoardUsersBlock/>
                <div className="card">
                    <DashboardBrandStoresMap/>
                </div>

                <div className="row">
                    <DashboardBoardHooks/>
                    <DashboardBoardSales/>
                </div>
            </div>
        )
    },
});
