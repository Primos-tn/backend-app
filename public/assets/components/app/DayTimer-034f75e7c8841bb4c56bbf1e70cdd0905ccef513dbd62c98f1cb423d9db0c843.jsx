//
var DayTimer = React.createClass({
    /**
     *
     */
    getInitialState: function () {
        return {tomorrow: this.props.tomorrow};
    },
    /**
     *
     * @private
     */
    _update (){
        var tomorrow = new Date();
        tomorrow.setTime(tomorrow.getTime() + 60 * 60 * 24  * 1000);
        tomorrow.setHours(0);
        tomorrow.setMinutes(0);
        tomorrow.setSeconds(0);
        var timerId =
            countdown(
                tomorrow,
                function (ts) {
                    //if (ts.value > 0){
                    if (ts.hours == 0 && ts.minutes == 0 && ts.seconds == 0) {
                        window.clearInterval(timerId);
                        App.Dispatcher.dispatch(App.Constants.END_DAY);
                    }
                    document.getElementById('pageTimer').innerHTML = ts.toHTML("strong");
                    //}
                    /*else {

                     }*/
                },
                countdown.HOURS | countdown.MINUTES | countdown.SECONDS);
        //
        //this.setState({'tomorrow': this.state.tomorrow - 1000});
        //setTimeout(this._update.bind(this), 1000);

    },
    /**
     */
    componentDidMount: function () {
        var locale= i18n.countdown ;
        if (locale){
            countdown.setLabels(locale.singular, locale.multiple, locale.and, locale.comma, locale.now);
        }
        this._update();
    },
    /**
     */
    componentWillUnmount: function () {

    },
    /**
     *
     */
    render: function () {
        return (
            <div className="col-lg-12 text-center NoPadding">
                <div className="col-lg-12">
                    <div className=" DayTimer">
                        <span id="pageTimer">{this.state.tomorrow}</span>
                    </div>
                </div>
            </div>
        );
    },
});