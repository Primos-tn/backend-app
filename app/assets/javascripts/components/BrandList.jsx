// app/assets/javascripts/components/article.js.jsx
var BrandList = React.createClass({
    actions : {
        list : "LIST"
    },
  /**
   *
   */
    loadDataFromServer : function() {
      App.Stores.loadData({
        url : App.Routes.brands ,
          action :this.actions.list
      });
    },

    /**
     *
     */
    componentDidMount: function() {
        App.Dispatcher.attach (this.actions.list, this.onDataChange);
        this.loadDataFromServer();
    },
    /**
     *
     */
    componentWillUnmount: function() {
        App.Dispatcher.detach (this.actions.list, this.onDataChangeListener);
    },
    /**
     *
     */
    getInitialState: function() {
        return {items: []};
    },
    /**
     *
     */
    onDataChange : function (result){
         this.setState ({items : result.brands});
    },
    /**
     *
     */
   render: function() {
     var items ;
       if (this.state.items.length){
       items = this.state.items.map(function (item, index){
          return <Brand item={item} key={index}/> ;
       }.bind(this));
     }
     else {
          items = "Loading ...."
     }


      return (
        <div>
          <h2> trending Brands </h2>
           <ul className="article-list">
              {items}
           </ul>
          </div>
      );
   },
});
