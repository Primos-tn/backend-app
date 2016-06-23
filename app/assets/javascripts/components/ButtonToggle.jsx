// app/assets/javascripts/components/header.js.jsx
var ButtonToggle = React.createClass({
    /**
     *
     */
   render: function() {
      var following = this.props.isFollowing ;
      return (
      <div className="onoffswitch">
       <input type="checkbox" defaultChecked={following ? "checked" : false }  onChange={this.props.onToggle} name="onoffswitch" className="onoffswitch-checkbox" id={"myonoffswitch-" + this.props.index }/>
       <label className="onoffswitch-label" htmlFor={"myonoffswitch-" + this.props.index }  >
           <span className="onoffswitch-inner"></span>
           <span className="onoffswitch-switch"></span>
       </label>
      </div>
      );
   },
});
