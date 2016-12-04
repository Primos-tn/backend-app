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
        if (this.props.id){
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
                <DashboardBoardSmallWidgetBlock/>
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
