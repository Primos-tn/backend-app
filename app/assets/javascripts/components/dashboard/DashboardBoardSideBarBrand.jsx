// app/assets/javascripts/components/article.js.jsx
var DashboardBoardSideBarBrandBlock = React.createClass({
    /**
     *
     */
    _ids: {
        COVER_INPUT_ID: 'cover_input',

    },
    /**
     *
     */
    componentDidMount: function () {

    },
    /**
     *
     */
    componentWillUnmount: function () {

    },
    /**
     *
     */
    _$file: null,
    /**
     *
     */
    loadDataFromServer: function () {

    },
    /**
     *
     * @private
     */
    _ajaxUploadBrandCover: function () {

        //var fd = new FormData();
        //fd.append('file', input.files[0] );
        var $form = $(this.refs[this._ids.COVER_INPUT_ID]).closest('form');
        $form.trigger('sumbit');
        /*
         $.ajax({
         url: 'http://example.com/script.php',
         data: fd,
         processData: false,
         contentType: false,
         type: 'POST',
         success: function(data){
         alert(data);
         }
         });*/
    },
    /**
     *
     * @private
     */
    _uploadBrandCover: function () {
        //var file = $(ReactDOM.findDOMNode(this)).find('form')[0];
        var $form = $(this.refs[this._ids.COVER_INPUT_ID]).closest('form');
        $form.trigger('submit');
    },
    /**
     *
     * @private
     */
    _triggerInput: function (e) {
        e.preventDefault();
        $(this.refs[this._ids.COVER_INPUT_ID]).trigger('click');
    },
    /**
     *
     */
    render: function () {
        var link = <i className="ti-camera"></i>;
        let style = {};
        let onClick ;

        if (this.props.image) {
            if (this.props.type == "cover") {
                style = {
                    background: "url(" + App.Helpers.getMediaUrl(this.props.image) + ") ",
                    backgroundAttachment: "fixed",
                    backgroundPosition: "center",
                    height: "200px",
                    backgroundRepeat: "no-repeat",
                    backgroundSize: "cover"
                };
            }
            else {
                link = <img src={App.Helpers.getMediaUrl(this.props.image)}/>
            }

        }
        let formName = "brand[" + this.props.type + "]";
        let className = "DashboardSideBar__uploadIcon " + this.props.type ;
        return (
            <div style={style}>
                <input name={formName}
                       type="file"
                       ref={this._ids.COVER_INPUT_ID}
                       id={this._ids.COVER_INPUT_ID}
                       onChange={this._uploadBrandCover}
                       style={{width:'0px', height : '0px'}}/>

                <div className={className} onClick={this._triggerInput}>
                    {link}
                </div>
            </div>
        )
    },
});
