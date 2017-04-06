
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
        let tomorrow = App.Helpers.getTomorrow();
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
        var locale = i18n.countdown;
        if (locale) {
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
            <div className="DayTimer">
                <span id="pageTimer">{this.state.tomorrow}</span>
            </div>
        );
    },
});
