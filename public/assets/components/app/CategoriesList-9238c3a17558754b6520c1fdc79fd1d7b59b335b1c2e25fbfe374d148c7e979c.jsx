// app/assets/javascripts/components/article.js.jsx
var CategoriesList = React.createClass({
    actions: {
        list: "Categories_LIST"
    },

    /**
     *
     */
    getInitialState: function () {
        return {items: [], selectedItems : []};
    },
    /**
     *
     */
    componentDidMount: function () {
        App.Dispatcher.attach(this.actions.list, this.onDataChange);
        this.loadDataFromServer();
    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(this.actions.list, this.onDataChange);
    },
    /**
     *
     */
    onDataChange: function (result) {
        console.log(result);
        this.setState({items: result.categories}, this._renderCarousel);
    },

    /**
     *
     */
    loadDataFromServer: function () {
        App.Stores.loadData({
            url: App.Routes.categories,
            action: this.actions.list
        });
    },
    /**
     *
     * @private
     */
    _renderCarousel (){
        var owl = $("#categories_carousel");
        owl.owlCarousel({
            itemsDesktop: [1000, 5], //5 items between 1000px and 901px
            itemsDesktopSmall: [900, 3], // betweem 900px and 601px
            itemsTablet: [600, 2], //2 items between 600 and 0
            itemsMobile: false // itemsMobile disabled - inherit from itemsTablet option
        });
        owl.find('.item').on('click', function (event) {
            var $this = $(event.currentTarget);
            let selectedItems = this.state.selectedItems ;
            let id = $this.data('filter');
            if ($this.hasClass('clicked')) {
                selectedItems = selectedItems.filter(function (entry){
                    return id != entry;
                });
                $this.removeAttr('style').removeClass('clicked');
            } else {
                selectedItems.push(id);
                $this.addClass('clicked');
            }
            this.setState({selectedItems : selectedItems});
            console.log(selectedItems);
            this.props.onCategoriesSelected (selectedItems);
        }.bind(this));
    },
    /**
     *
     */
    render: function () {
        var items = [];
        this.state.items.forEach(function (item, index) {
            items.push(
                <div className="item" key={index} data-filter={item.id}>
                    <i className={item.icon_class_name} ></i>
                    <h6>{item.name}</h6>
                </div>
            );
        });
        return (
            <div>
                <div id="categories_carousel" className="owl-carousel owl-theme">
                    {items}
                </div>
            </div>
        );
    },
});
