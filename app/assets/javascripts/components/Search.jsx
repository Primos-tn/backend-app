var Search = React.createClass({
    actions : {
        SEARCH : 'search'
    },
    /**
     *
     */
    getInitialState: function() {
        return {searchResults: []};
    },
    /**
   *
   */
    loadDataFromServer : function() {
      App.Stores.loadData({
        url : App.Routes.search,
          action : this.actions.SEARCH
      });
    },

    /**
     */
    componentDidMount : function (){
        App.Dispatcher.attach(this.actions.SEARCH, this.searchChanged);
    },
    /**
     */
    componentWillUnmount : function (){
        App.Dispatcher.detach(this.actions.SEARCH, this.searchChanged);
    },
    /**
     *
     */
    searchChanged : function (data){
      this.setState ({searchResults : data.results});
    },
    /**
     *
     */
   render: function() {
        return (
            <div>
            <input onChange={this.loadDataFromServer}/>
        </div>
        );
   },
});
