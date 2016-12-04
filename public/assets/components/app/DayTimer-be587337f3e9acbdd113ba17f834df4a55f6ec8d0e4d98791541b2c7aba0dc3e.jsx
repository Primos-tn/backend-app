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
        if (this.state.tomorrow > 0) {
            this.setState({'tomorrow': this.state.tomorrow -1000});
            setTimeout(this._update.bind(this), 1000);
        }
        else {
            App.Dispatcher.dispatch(App.Constants.END_DAY);
        }
    },
    /**
     */
    componentDidMount: function () {
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
            <div className="col-lg-12 text-center">
                <div className="col-lg-12">
                    <div className=" DayTimer">
                        <span>{this.state.tomorrow}</span>
                    </div>
                </div>
            </div>
        );
    },
});
