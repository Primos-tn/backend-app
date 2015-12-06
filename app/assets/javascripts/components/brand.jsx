var Brand = React.createClass({
  getInitialState : function (){
    //super ();
    this.unFollowUrl = App.Helpers.formatUrl(App.Routes.unFollowBrand , { id : this.props.item.id });
    this.followUrl = App.Helpers.formatUrl( App.Routes.followBrand , { id : this.props.item.id });
    this.setState({following : this.props.item.following});
    this.action = "brand_" + this.props.item.id ;

  },
  /**
   */
  componentDidMount : function (){
      App.Dispatcher.attach(this.action, this.itemChanged);
  },
  /**
   *
   */
  componentWillUnmount : function (){
      App.Dispatcher.detach (this.action, this.itemChanged);
  },
  /**
   *
   */
  itemChanged : function (data){
      this.setState({following : data.following})
  },
  /**
   *
   */
    onToggle : function (data){
      console.warn (">>> " + this.followUrl);
      App.Stores.request({
         url : this.following ? this.followUrl : this.unFollowUrl ,
         action : this.action
      });
    },
    /**
     *
     */
    render : function (){
      var item = this.props.item ;

      return (
         <li className="article" key={item.id}>
            <h2 className="name">{item.name}</h2>
           <div className="switcher">
             <ButtonToggle key={item.id} checked={this.following}  index={item.id} onToggle={this.onToggle}/>
           </div>
            <ul className="details">
                 <li className="info">
                     <span className="label">by </span>
                     <span className="label">45 views </span>
                     <span className="label">17 wishes </span>
                   </li>
                   <li className="info">
                     <button className="button button-share"></button>
                   </li>
               </ul>
         </li>
      );
    }
});
// app/assets/javascripts/components/article.js.jsx
var Brands = React.createClass({
  /**
   *
   */
    loadDataFromServer : function() {
      App.Stores.loadData({
        url : this.props.url ,
      });
    },
    /**
     *
     */
    onDataChange : function (data){
      this.setState ({data : data});
    },
    /**
     *
     */
   render: function() {
     var items ;
       if (this.state.data.length){
       items = this.state.data.map(function (item, index){
          return <Brand item={item} key={index}/> ;
       }.bind(this));
     }
     else {
          items = "Loading ...."
     }


      return (
        <div>
          <h2>Brands </h2>
           <ul className="article-list">
              {items}
           </ul>
          </div>
      );
   },
   /**
    *
    */
   getInitialState: function() {
      return {data: []};
    },
    /**
     *
     */
    componentDidMount: function() {

       App.Dispatcher.attach (this.props.url, this.onDataChange);
       this.loadDataFromServer();
   },
   /**
    *
    */
   componentWillUnmount: function() {
      App.Dispatcher.detach (this.props.url, this.onDataChangeListener);
  }
});
