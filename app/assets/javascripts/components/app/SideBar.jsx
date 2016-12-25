// app/assets/javascripts/components/header.js.jsx

var SideBar = React.createClass({
    /**
     *
     */
    render: function () {
        var profile = this.props.is_logged_in ;
        var profileBlock = null ;
        if  (profile ){
            profileBlock = <div>profile</div>;
        }
        return (
            <div className="AppSideBar">
                {profileBlock}
                <div className="AppSideBar__Header AppSideBar__Header--top">
                    <span>{i18n['Similar products'] }</span>
                </div>

                <div className="AppSideBar__Header">
                    <span>{i18n['Similar brands'] }</span>
                </div>

                <SideBarFooter />
            </div>

        );
    },
});
