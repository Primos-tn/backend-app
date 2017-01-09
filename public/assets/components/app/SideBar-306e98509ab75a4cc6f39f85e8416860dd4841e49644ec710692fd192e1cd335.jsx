// app/assets/javascripts/components/header.js.jsx

var SideBar = React.createClass({
    /**
     *
     */
    render: function () {
        /**
         * NEXT_VERSION
         * <div className="AppSideBar__Header AppSideBar__Header--top">
         <span>{i18n['Similar products'] }</span>
         </div>

         <div className="AppSideBar__Header">
         <span>{i18n['Similar brands'] }</span>
         </div>
         */
        var profile = this.props.isLoggedIn;
        var profileBlock = null;
        if (profile) {
            profileBlock = <UserProfileSideBar/>;
        }
        var isProductsView = this.props.isProductsView;
        var isItemView = this.props.isItemView;
        let components;
        if (isProductsView) {
            components = isItemView ? <SideBarProduct /> : <SideBarProducts/>;
        }
        else {
            components = isItemView ? <SideBarBrand /> : <SideBarBrands/>;
        }
        return (
            <div className="AppSideBar">
                {profileBlock}
                {components}
                <SideBarFooter />
            </div>

        );
    },
});
