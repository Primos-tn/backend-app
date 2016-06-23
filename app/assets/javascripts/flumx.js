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
   dispatch : function (action, data, event){
     if (App.Dispatcher._listeners[action]){
        App.Dispatcher._listeners[action].forEach(function (callback){
              callback (data, event);
        });
     }
   }
};

/**
 * Mininmum facebook Store
 */
App.Stores = {
  /**
   *
   * @param options
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
       console.error(options.action || options.url, status, err.toString());
     }.bind(this)
    });
  },
  /**
   *
   * @param options
   */
  post : function (options){
    $.ajax({
      type : 'POST',
      url : options.url ,
      data : options.data || {},
      success : function(data) {
        App.Dispatcher.dispatch(options.action || options.url, data, options.event || {});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(options.action || options.url, status, err.toString());
      }.bind(this)
    });
  },
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
  }
};
/**
 *
 */
var routes = {
  search : 'search',
  brands : 'brands',
  followBrand : 'brands/:id/follow',
  unFollowBrand : 'brands/:id/unfollow',
  products : 'products',
  wishList : 'products/:id/whish',
};
//
var baseApiUrl = "/api/v1/";
App.Routes = {};
for (var key in routes){
  App.Routes[key] = baseApiUrl + routes[key] ;
}

