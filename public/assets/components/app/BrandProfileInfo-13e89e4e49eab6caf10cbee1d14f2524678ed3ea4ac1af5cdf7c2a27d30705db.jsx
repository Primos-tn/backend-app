var BrandProfileInfo = React.createClass({

    /**
     *
     */
    render: function () {
        let info = this.props.brandInfo;
        return (
            <div className="BrandProfile__InfoContainer">
                <span className="BrandProfile__InfoItem"><i className="ti-location-pin"></i> {info.address} </span><br/>
                <span  className="BrandProfile__InfoItem"><i className="ti-lamp"></i> {info.category} </span><br/>
                <span className="BrandProfile__InfoItem"> {this.props.brandInfo.creation_date}</span><br/>
                <div>
                    <span className="BrandProfile__InfoItem"><a href={this.props.brandInfo.fb_link}><i className="ti-facebook"></i></a></span>
                    <span className="BrandProfile__InfoItem"><a href={this.props.brandInfo.ln_link}><i className="ti-linkedin"></i></a></span>
                    <span className="BrandProfile__InfoItem"><a href={this.props.brandInfo.tw_link}><i className="ti-twitter"></i></a></span>
                </div>

            </div>
        )
    }
});
