
var EmptyFollowersList = React.createClass({
    render : function () {
        return (
            <div className="col-lg-12 text-center">Empty</div>
        )
    }
});

/**
 *
 * @type {*|Function}
 */
var Loading = React.createClass({
    render : function () {
        return (
            <div className="col-lg-12 text-center">{i18n.Loading}</div>
        )
    }
});
/**
 *
 * @type {*|Function}
 */
var EmptyProductsList = React.createClass({
    render : function () {
        return (
            <div className="col-lg-12 ProductCardLisContainerEmpty">{i18n.Empty}</div>
        )
    }

})

/**
 *
 * @type {*|Function}
 */
var EmptyList = React.createClass({
    render : function () {
        return (
            <div className="col-lg-12">{i18n.Empty}</div>
        )
    }

})