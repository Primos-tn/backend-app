var ProductPropertiesEdit = React.createClass({
    /**
     *
     */
    getInitialState(){
        return {
            properties: this.props.properties || {},
            defaults: this.props.defaults
        }
    },
    /**
     *
     * @param newstate
     * @private
     */
    _changeState(newstate){
        this.setState({properties: newstate});
    },
    /**
     *
     * @param key
     * @param e
     */
    _change (key, e){
        let oldProperties = this.state.properties;
        oldProperties[key] = e.currentTarget.value;
        this._changeState(oldProperties);
    },
    /**
     *
     */
    _remove(key, e){
        e.preventDefault();
        let oldProperties = this.state.properties;
        delete oldProperties[key];
        this._changeState(oldProperties);

    },
    /**
     *
     */
    _add (e){
        e.preventDefault();
        var dom = ReactDOM.findDOMNode(this);
        let $select = $(dom).find('select').first();
        let oldProperties = this.state.properties;
        oldProperties[$select.val()] = "";
        console.log(oldProperties);
        this._changeState(oldProperties);

    },
    /**
     *
     */
    render  () {
        var properties = this.state.properties;
        var defaults = this.state.defaults;
        // used to translate
        // keys translations
        let translations = {};
        let defaultOptions = [];
        defaults.forEach(function (entry) {
            defaultOptions.push(<option value={entry[1]}>{entry[0]}</option>)
            translations[entry[1]] = entry[0];
        });

        //
        var currentPropertiesElements = [];
        let value;
        for (var key in properties) {
            value = properties[key];
            currentPropertiesElements.push(
                <div>
                    <label>{translations[key]}</label>
                    <input onChange={this._change.bind(this, key)} defaultValue={value}/>
                    <button onClick={this._remove.bind(this, key)} className="bn btn-sm btn-danger"><i className="ti-trash"></i>
                    </button>
                </div>)
        }



        return (
            <div>
                <div>
                    <select>
                        {defaultOptions}
                    </select>
                    <button onClick={this._add} className="bn btn-wd">+</button>
                </div>
                <div>
                    {currentPropertiesElements}
                </div>
            </div>

        )
    }
});