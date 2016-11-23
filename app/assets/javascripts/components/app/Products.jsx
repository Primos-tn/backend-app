/**
 *
 */
var Products = React.createClass({
    /**
     *
     */
    actions: {
        list: "PRODUCTS_LIST"
    },
    getInitialState(){
        return {endDay: false}
    },
    /**
     *
     * @private
     */
    _endDay (){
        this.setState({endDay: true})
    },
    /**
     *
     */
    componentDidMount(){
        App.Dispatcher.attach(App.Constants.END_DAY, this._endDay);
    },
    /**
     *
     */
    render () {
        let component;
        if (!this.state.endDay) {
            component = (

                <div className="col-lg-12">
                    <PopularEmbedList type="Product"/>
                    <div className="col-lg-12">
                        <div className="Block__Header">
                            <span>Products of day</span>
                            <div className="pull-right">
                                Filter
                            </div>
                        </div>
                        <ProductsList />
                    </div>
                </div>
            )
        }
        else {
            component = (
                <div className="text-center col-lg-12"><span>Next Day !!</span></div>

            )
        }
        return (
            <div>
                {component}
            </div>
        );
    },
});
