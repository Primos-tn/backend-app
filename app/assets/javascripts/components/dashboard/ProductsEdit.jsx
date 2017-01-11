var ProductPropertiesEdit = React.createClass({
    /**
     *
     */
    getInitialState(){
        let properties = {};
        try {
            properties = JSON.parse(this.props.properties);
        }
        catch (e){
            // pass
        }
        return {
            properties: properties,
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
        App.Dispatcher.dispatch('dashboard:product:edit:properties', newstate);
        $('#product_properties').first().val(JSON.stringify(newstate));
    },
    /**
     *
     * @param key
     * @param e
     */
    _validate (key, e){
        e.preventDefault();
        let oldProperties = this.state.properties;
        let parent = ReactDOM.findDOMNode(this.refs[key]);
        let $input = $(parent).find('input.value');
        let $span = $(parent).find('span.value');
        let value = $input.val();
        if (value.length) {
            oldProperties[key] = value;
            $span.html(value);
            $input.hide();
            $span.show();
            this._changeState(oldProperties);
        }
    },
    /**
     *
     * @param key
     * @param e
     */
    _edit (key, e){
        e.preventDefault();
        let oldProperties = this.state.properties;
        let parent = ReactDOM.findDOMNode(this.refs[key]);
        let $input = $(parent).find('input.value');
        let $span = $(parent).find('div.value');
        $span.hide();
        $input.show();
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
    _addCustom (e){
        e.preventDefault();
        let input = ReactDOM.findDOMNode(this.refs.customProperty);
        let newKey = input.value;
        let oldProperties = this.state.properties;
        // check of length > 0 and not already exists
        if (newKey.length && !oldProperties[newKey]) {
            oldProperties[newKey] = "";
            this._changeState(oldProperties);
        }

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
                <div className="ProductPropertiesEdit__PropertyContainer" ref={key}>
                    <br/>
                    <label className="key">{translations[key] || key}</label>
                    <input className="value" defaultValue={value}/>
                    <div className="value "></div>
                    <div className="btn-group btn-group-sm">
                        <button onClick={this._validate.bind(this, key)} className="btn btn-primary"><i
                            className="ti-check"></i></button>
                        <button onClick={this._edit.bind(this, key)} className="btn btn-sm btn-default"><i
                            className="ti-pencil"></i>
                        </button>
                        <button onClick={this._remove.bind(this, key)} className="btn btn-sm btn-danger"><i
                            className="ti-trash"></i>
                        </button>
                    </div>
                </div>
            )
        }


        return (
            <div>
                <div>
                    <select>
                        {defaultOptions}
                    </select>
                    <button onClick={this._add} className="bn btn-wd">+</button>
                    <input ref="customProperty" placeholder={i18n['add your custom property']}/>
                    <button onClick={this._addCustom} className="bn btn-wd">+</button>
                </div>
                <div>
                    {currentPropertiesElements}
                </div>
            </div>

        )
    }
});