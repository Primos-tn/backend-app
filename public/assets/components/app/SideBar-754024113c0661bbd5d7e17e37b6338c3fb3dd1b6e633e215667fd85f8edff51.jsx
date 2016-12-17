// app/assets/javascripts/components/header.js.jsx

var SideBar = React.createClass({
    /**
     *
     */
    render: function () {
        return (
            <div className="AppSideBar">
                <UserProfile id={this.props.id}/>
                <span>{i18n['Brands'] }</span>
                <UserBrands id={this.props.id}/>
                <SideBarFooter />
            </div>

        );
    },
});
