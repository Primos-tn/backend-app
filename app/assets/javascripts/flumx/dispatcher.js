
/**
 * Minimum flux implementation
 */
var dispatcher = {
  /**
   * Store all listener
   */
  _listeners: [],
  /**
   * @param action to be attached
   * @param callback to execute
   */
  attach: function (action, callback, params) {
    if (!App.Dispatcher._listeners[action]) {
      // create callback in list of events
      App.Dispatcher._listeners[action] = {};
    }
    // save dispatch id to be deleted so we can delete it later
    var dispatchId = Date.now();
    App.Dispatcher._listeners[action][dispatchId] = callback;
    callback.__dispatecherID__ = dispatchId;
  },
  /**
   *
   */
  detach: function (action, callback) {
    if (callback.__dispatecherID__) {
      delete App.Dispatcher._listeners[action][callback.__dispatecherID__];
    }
    // remove
    delete callback.__dispatecherID__;
  },
  /**
   * @param {Object} action to be attached
   * @param {Object} data event source
   * @param {Object} event to execute
   */
  dispatch: function (action, data, event) {
    // local notification
    // lookup , when you send notification from current interface
    if (App.Dispatcher._listeners[action]) {
      App.Dispatcher._dispatchToListener(action, data, event)
    }
  },
  /**
   *
   * @private
   */
  _dispatchToListener: function (action, data, eventSource) {
    var listeners = App.Dispatcher._listeners[action];
    for (var entry in listeners) {
      listeners[entry](data, eventSource);
    }
  },
  /**
   * Future usage
   */
  notifyAll: function (notification) {
    // server notification
    var actionName = (notification || {}).action ;
    var data = notification.data ;
    if (actionName  &&  App.Dispatcher._listeners[actionName]) {
      App.Dispatcher._dispatchToListener(actionName, data);
    }
  }
};
App.Dispatcher = dispatcher;
App.Dispatcher.removeListener = dispatcher.detach;