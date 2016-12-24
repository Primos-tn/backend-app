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
     */
    filter : function (){
        alert('x')
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

                <div>
                    <DayTimer/>
                    <PopularEmbedList type="Product"/>
                    <div>
                        <div className="Block__Header">
                            <span>{i18n['Products of day']}</span>
                            <div className="pull-right">
                                <span onClick={this.filter}>{i18n['Filter']}<i className="ti-plus"></i></span>
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
