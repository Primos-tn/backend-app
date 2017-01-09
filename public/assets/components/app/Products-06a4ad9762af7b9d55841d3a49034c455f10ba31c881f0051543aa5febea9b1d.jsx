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
    /**
     * 
     * @returns {{endDay: boolean}}
     */
    getInitialState(){
        return {endDay: false}
    },
    /**
     *
     */
    filter: function () {
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
                    <ProductsList />
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
                <div>
                    {component}
                </div>
                <div className="clearfix"></div>
            </div>
        );
    },
});
