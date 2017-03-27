/**
 *
 */
var MapView = React.createClass({
    /**
     *
     */
    actions: {
        list: "PRODUCTS_LIST"
    },
    /**
     *
     * @param dir
     */
    loopit(dir){
        let diff = this.state.tomorrow - Date.now();
        let hours = 0;
        let minutes = 0;
        if (diff > 0) {
            hours = Math.floor((diff % 86400000) / 3600000);
            minutes = Math.round(((diff % 86400000) % 3600000) / 60000);
            $('.MapCounter').html([hours, minutes].join(':'));
            // recursive call
            setTimeout(function () {
                this.loopit();
            }.bind(this), 60000);
        }
    },
    /**
     *
     */
    getInitialState: function () {
        let tomorrow = new Date(Date.now() + (24 * 60 * 60 * 1000));
        tomorrow.setUTCHours(0);
        tomorrow.setUTCMinutes(0);
        tomorrow.setUTCSeconds(0);
        return {items: [], serverLoadingDone: false, filter: {}, filterShow: false, tomorrow: tomorrow.getTime()};
    },
    /**
     *
     */
    getServerItems: function () {
        // get query
        let query = $.extend({
            brands: this.props.brand
        }, this.state.filter);

        App.Stores.loadData({
            url: App.Routes.products,
            action: this.actions.list,
            query: query
        });
    },

    /**
     *
     */
    componentDidMount () {
        setTimeout(function () {
            this.loopit();
        }.bind(this), 1000);
        App.Dispatcher.attach(this.actions.list, this.onDataChange);
        App.Dispatcher.attach(App.Actions.FILTER_CHANGED, this.filterChanged);
        this.getServerItems();
    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(this.actions.list, this.onDataChange);
        App.Dispatcher.detach(App.actions.FILTER_CHANGED, this.filterChanged);
        $('.MapFilterContainer').draggable();
    },
    /**
     *
     */
    toggleFilter: function () {
        this.setState({filterShow: !this.state.filterShow})
    },
    /**
     *
     */
    onMapAreaChanged  (filter){
    },
    /**
     *
     */
    onDataChange: function (result) {
        this.setState({items: result.products, serverLoadingDone: true}, function () {

        });
    },
    /**
     *
     */
    render: function () {
        return (
            <div>
                <div className="MapFilterContainer" style={{'display' : this.state.filterShow ? 'block' : 'none'}}>
                    <div className="MapFilterContainer__Inner">
                        <span className="MapFilterContainer__closer ti-close" onClick={this.toggleFilter}></span>

                        <CategoriesList onCategoriesSelected={this.onCategoriesSelected} type="Product"/>
                        <RangeSlider onSliderChanged={this.onSliderChanged}/>
                    </div>
                </div>
                <div className="MapFilterShow" onClick={this.toggleFilter}
                     style={{'display' : this.state.filterShow ? 'none' : ''}}>
                    <span className="ti-filter"></span>
                </div>
                <div className="MapCounter">

                </div>
                <Map onMapAreaChanged={this.onMapAreaChanged}></Map>
            </div>
        )
    }
});
