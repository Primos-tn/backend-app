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
                <div className="Block__Header">
                    <span>{i18n['Similar products'] }</span>
                </div>

                <div className="Block__Header">
                    <span>{i18n['Similar brands'] }</span>
                </div>

                <SideBarFooter />
            </div>
        );
    },
});
