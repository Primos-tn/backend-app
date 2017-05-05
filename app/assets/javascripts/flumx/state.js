/**
 * Errors
 */
App.State = {
    /**
     *
     */
    setState : function (state, saveToLocaleStorage, localStorageKeyName){
        if (!window.state){
            window.state = {};
        }
        window.state = state ;
        /*
        if (localStorage){
            localStorage.set(localStorageKeyName, state)
        }*/
    },
    /**
     *
     * @returns {{}|*}
     */
    getState : function (){
        return window.state ;
    }
};