// app/assets/javascripts/components/article.js.jsx
var DashboardBoardSideBarBrandBlock = React.createClass({
    /**
     *
     */
    _ids : {
        COVER_INPUT_ID : 'cover_input',

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
    _$file :null,
    /**
     *
     */
    loadDataFromServer: function () {

    },
    /**
     *
     * @private
     */
    _ajaxUploadBrandCover : function (){

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
    _uploadBrandCover : function (){
        //var file = $(ReactDOM.findDOMNode(this)).find('form')[0];
        var $form = $(this.refs[this._ids.COVER_INPUT_ID]).closest('form');
        $form.trigger('submit');
    },
    /**
     *
     * @private
     */
    _triggerInput : function (e){
        e.preventDefault();
        $(this.refs[this._ids.COVER_INPUT_ID]).trigger('click');
    },
    /**
     *
     */
    render: function () {
        var link = <i className="ti-camera"></i>;
        if (this.props.image){
            link = <img src={App.Helpers.getMediaUrl(this.props.image)} />
        }
        return (
            <div>
                <input name="brand[cover]"
                       type="file"
                       ref={this._ids.COVER_INPUT_ID}
                       id={this._ids.COVER_INPUT_ID}
                       onChange={this._uploadBrandCover}
                       style={{width:'0px', height : '0px'}}/>

                <div className="DashboardSideBar__uploadIcon" onClick={this._triggerInput}>
                    {link}
                </div>
            </div>
        )
    },
});
