// app/assets/javascripts/components/header.js.jsx

var SideBarFooter = React.createClass({
    /**
     *
     */
    render: function () {
        return (
            <div className="AppSideBar__Footer">

                <div className="AppAndroidStoreLink">
                    <a href='http://play.google.com/store?utm_source=global_co&utm_medium=prtnr&utm_content=Mar2515&utm_campaign=PartBadge&pcampaignid=MKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'>
                        <img alt='undefined'
                             src='https://play.google.com/intl/en_us/badges/images/generic/ar_badge_web_generic.png'/></a>
                </div>
                <div className="SideBarFooter__Company">
                    <a href="#"><i className="  ti-facebook"></i></a>
                    <a href="#"><i className="ti-linkedin"></i></a>
                    <a href="#"><i className="ti-twitter"></i></a>
                    <span>© 2016</span>
                </div>
            </div>
        );
    },
});
