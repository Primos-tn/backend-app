;
/**
 * Mininmum facebook flux implementation
 */
App.Dispatcher = {
  /**
   *
   */
  _listeners : [],
  /**
   * @param action to be attached
   * @param callback to excecute
   */
  attach : function (action, callback){
    if (!App.Dispatcher._listeners[action]){
        // create callback in list of events
         App.Dispatcher._listeners[action] = [];
    }
    App.Dispatcher._listeners[action].push (callback);
  },
  /**
   * @param action to be attached
   * @param data to excecute
   */
   dispatch : function (action, data){
     if (App.Dispatcher._listeners[action]){
        App.Dispatcher._listeners[action].forEach(function (callback){
              callback (data);
        });
     }
   }
};

/**
 * Mininmum facebook Store
 */
App.Stores = {
  /**
   * @param event to be attached
   * @param callback to excecute
   */
  loadData : function (options){
    $.ajax({
      type : 'GET',
      url : options.url ,
      dataType : 'json',
      success : function(data) {
        App.Dispatcher.dispatch(options.action || options.url, data);
      }.bind(this),
     error: function(xhr, status, err) {
       console.error(this.props.url, status, err.toString());
     }.bind(this)
    });
  },
  /**
   *
   */
  request : function (options){
    $.ajax({
      type : options.type || 'GET',
      url : options.url ,
      dataType : 'json',
      data : options.data,
      success : function(data) {
        App.Dispatcher.dispatch(options.action || options.action, data);
      }.bind(this),
     error: function(xhr, status, err) {
       console.error(this.props.url, status, err.toString());
     }.bind(this)
   });
  }
};

/**
 * Mininmum facebook Store
 */
App.Helpers = {
  /**
   * Format an url given a key, value object
   * foo/:bar , { bar : "alex" } will be transformed to foo/alex
   */
  formatUrl : function (url, data){
    for (var key in data){
      url = url.replace (':' + key, data[key]);
    }
    return url ;
  },
};

/**
 * Mininmum facebook Store
 */
App.Routes = {
  /**
   * Format an url given a key, value object
   * foo/:bar , { bar : "alex" } will be transformed to foo/alex
   */
  followBrand : 'brand/:id/follow',
  unFollowBrand : 'brand/:id/follow',

  
};
