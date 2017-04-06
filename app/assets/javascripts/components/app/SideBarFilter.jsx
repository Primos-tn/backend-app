// app/assets/javascripts/components/header.js.jsx
var ColorsSelector = React.createClass({
    /**
     *
     * @returns {{selectedColors: Array}}
     */
    getInitialState(){
        return {
            selectedColors: []
        }
    },
    /**
     *
     */
    _reset (){
        this._updateSelectedColors([]);
    },
    /**
     *
     * @param color
     */
    _selectColor (color){
        let selectedColors = this.state.selectedColors;
        // exists
        if (selectedColors.indexOf(color) > -1) {
            selectedColors = selectedColors.filter(function (item) {
                return item != color
            })
        }
        else {
            selectedColors.push(color);
        }
        console.log(selectedColors);
        this._updateSelectedColors(selectedColors);
    },
    /**
     *
     * @param selectedColors
     * @private
     */
    _updateSelectedColors (selectedColors){
        this.setState({'selectedColors': selectedColors});
        this.props.onColorSelectedChange(selectedColors);
    },
    /**
     *
     * @private
     * Used to handle out of closure in forEach loop
     */
    _addColorItem (color, className){
        return (<div className={className} href="?default=true" key={color}
                     onClick={this._selectColor.bind(this, color)}
                     style={{"background" : color}}>
        </div>)
    },
    /**
     *
     * @returns {XML}
     */
    render (){
        let colors = ["#F1002D", "#0EBCF2", "#B66672",
            '#12A641', '#4F96B6', '#E45E66', '#96AA66',
            '#5B84AA', '#74C683', '#30BBB1', '#7646B8',
            '#1A5AE4', '#966650', '#FF1D13', '#cf315a'];
        let items = [];
        let selectedColors = this.state.selectedColors;
        let className = 'FilterBlock__ColorChoice';
        let currentClassName = className;
        colors.forEach(function (color) {
            currentClassName = className;
            if (selectedColors.indexOf(color) > -1) {
                currentClassName += ' FilterBlock__ColorChoice--Selected';
            }

            items.push(this._addColorItem(color, currentClassName));
        }.bind(this));
        return (
            <div className="FilterBlock">
                <div className="AppSideBar__Header">Color
                    <input type="checkbox" className="pull-left" onClick={this._reset}/>
                </div>
                <div className="FilterBlock__ColorChoicesContainer">
                    {items}
                </div>
                <div className="line"></div>
            </div>)
    }
});

/**
 * Range slider
 */
var RangeSlider = React.createClass({
    componentDidMount(){
        let $slider = $("#slider-range");
        $slider.slider({
            range: true,
            min: 0,
            max: 3000,
            values: [75, 300],
            slide: function (event, ui) {
                $("#amount").val("$" + ui.values[0] + " - $" + ui.values[1]);
            },
            change: function (e, ui) {
                this.props.onSliderChanged(e, ui);
            }.bind(this)
        });
        $("#amount").val("$" + $slider.slider("values", 0) + " - $" + $slider.slider("values", 1));
    },
    render (){
        return (
            <div className="FilterBlock">
                <div className="FilterBlock__PriceRange">
                    <div className="AppSideBar__Header">
                        <span>Price range:</span>
                        <input type="text" id="amount" readonly
                               style={{border:0, color: '#f6931f', 'display' : 'inline-block'}}/>
                    </div>
                    <div className="FilterBlock__PriceRangeBody">
                        <div id="slider-range"></div>
                    </div>
                </div>
            </div>
        );
    }
});
var SideBarFilter = React.createClass({
    /**
     *
     * @returns {{map: null, color: null, categoriesList: null, range: null}}
     */
    getInitialState(){
        return {
            map: null,
            color: null,
            categoriesList: null,
            range: null
        }

    },
    /**
     *
     */
    componentDidMount () {
        this.$container = $('.AppSideBar');
        setTimeout(()=> {
            $('.AppContainer').css({'minHeight': 1000})
        }, 10);
        App.Dispatcher.attach(App.Actions.WINDOW_SCROLL, this.onWindowScrolled);
        this.onWindowScrolled(window.scrollY);

    },
    /**
     *
     */
    componentWillUnmount (){
        App.Dispatcher.detach(App.Actions.WINDOW_SCROLL, this.onWindowScrolled);

    },
    /**
     *
     */
    onWindowScrolled: function (value) {
        if (value > 50) {
            this.$container.addClass('fixed');
            var height = this.$container.height();
            var clientHeight = $(window).height();
            if (height > clientHeight) {
                height = height - clientHeight;
                console.log(value - height);
                this.$container.css({'top': -Math.abs(Math.min(height, value))})
            }

        } else {
            this.$container.removeClass("fixed");
            this.$container.css({'top': 0})
        }
        //console.log(value);
        /*if (value >  this.state.navBarHeight){
         $container.addClass("fixed");
         $('.AppContainer').css({'min-height': $container.height()})

         }
         else {

         }*/
    },
    /**
     *
     */
    componentWillUpdate(current, next){
        // FILTER_CHANGED
        App.Dispatcher.dispatch(App.Actions.FILTER_CHANGED, next);
    },
    /**
     *
     */
    onMapAreaChanged(map){
        let center = map.getCenter();
        var eastBound = map.getBounds().getEast();
        var centerEast = L.latLng(center.lat, eastBound);
        var dist = center.distanceTo(centerEast);
        this.setState({
            map: {
                center:[center.lat, center.lng],
                distance:  dist/2
            }
        });

    },
    /***
     *
     */
    onColorSelectedChange (color){
        this.setState({color: color});
    },
    /**
     *
     * @param categoriesList
     */
    onCategoriesSelected (categoriesList){
        this.setState({categoriesList: categoriesList});
    },
    /**
     *
     */
    onSliderChanged (range, ui){
        this.setState({range: ui.values});
    },
    /**
     *
     */
    render: function () {
        var profile = this.props.is_logged_in;
        var profileBlock = null;
        if (profile) {
            profileBlock = <UserProfileSideBar/>;
        }
        /*
         // #FUSAGE
         let colorsFilter = [];
         if (this.props.showColors) {
         colorsFilter.push(<ColorsSelector onColorSelectedChange={this.onColorSelectedChange}/>)
         }*/
        let priceRange = [];
        if (this.props.shwoPriceRange) {
            priceRange.push(
                <div>
                    <input type="checkbox" className="pull-left" onclick={this._reset}/>
                    <RangeSlider onSliderChanged={this.onSliderChanged}/>
                </div>)
        }
        return (
            <div>
                <div className="AppSideBar__Header AppSideBar__Header--top">
                    <input type="checkbox" className="pull-left" onclick={this._reset}/>
                    <span>Map</span>
                </div>
                <div className="AppSideBar__MapContainer">
                    <Map onMapAreaChanged={this.onMapAreaChanged} height="200px"/>
                </div>

                <div className="AppSideBar__Header">
                    <input type="checkbox" className="pull-left" onclick={this._reset}/>
                    <span>Categories</span>
                </div>
                <div className="AppSideBar__CategoriesContainer">
                    <CategoriesList onCategoriesSelected={this.onCategoriesSelected} type="Product"/>
                </div>
                {priceRange}
            </div>
        );
    }
});

