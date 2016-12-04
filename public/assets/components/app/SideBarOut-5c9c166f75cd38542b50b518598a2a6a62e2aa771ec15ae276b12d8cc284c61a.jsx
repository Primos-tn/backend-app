// app/assets/javascripts/components/header.js.jsx

var SideBarOut = React.createClass({
    /**
     *
     */
    componentDidMount : function (){
       // alert('x')
    },
    /**
     *
     */
    componentWillUnmount : function (){
        alert('x');
    },
    /**
     *
     */
    render: function () {
        return (
            <div className="AppSideBar">
                <div className="Block__Header col-lg-12">
                    <span>Similar Products</span>
                </div>

                <div className="Block__Header col-lg-12">
                    <span>Similar Brands</span>
                </div>

                <SideBarFooter />
            </div>
        );
    },
});
