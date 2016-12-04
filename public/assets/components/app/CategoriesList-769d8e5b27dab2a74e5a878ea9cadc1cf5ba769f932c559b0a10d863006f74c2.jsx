// app/assets/javascripts/components/article.js.jsx
var PopularEmbedList = React.createClass({
    /**
     *
     */
    render: function () {
        var items = [];
        [1, 2, 3, 4].forEach(function (item) {
            items.push(
                <div key={item} className="col-lg-3">
                    <div className="PopularEmbedList__Item">
                    <span className="PopularEmbedList__Title">
                        {item}
                    </span>
                    </div>
                </div>
            )
        });
        return (
            <div className="PopularEmbedList">
                <div className="Block__Header col-lg-12">
                    <span>Categories</span>
                </div>
                {items}
                <div className="clearfix"/>
            </div>
        );
    },
});
