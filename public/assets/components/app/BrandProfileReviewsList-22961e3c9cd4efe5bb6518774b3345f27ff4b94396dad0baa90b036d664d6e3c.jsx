/**
 *
 */
var BrandProfileReviewEdit = React.createClass({
    /**
     *
     */
    getInitialState: function () {
        return {
            isReviewing: false,
            mine : this.props.mine
        }
    },
    /**
     *
     */
    postReview: function () {
        if (!this.state.isReviewing) {
            this.setState({isReviewing: true});
            App.Stores.post({
                url: App.Routes.brandReviews,
                action: App.Actions.BRAND_EDIT_REVIEW,
                params: {
                    id: this.props.id
                },
                data: {
                    review: {
                        eval: 0,
                        body: this.refs.body_text.value
                    }
                }

            });
        }
    },
    /**
     *
     */
    componentDidMount: function () {
        App.Dispatcher.attach(App.Actions.BRAND_EDIT_REVIEW, this.onReviewDone);
    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(App.Actions.BRAND_EDIT_REVIEW, this.onReviewDone);
    },
    /**
     *
     */
    onReviewDone (){
        this.setState({isReviewing: false});
    },
    /**
     *
     */
    render: function () {
        return (
            <div className="BrandProfile__ReviewForm">
                <textarea  ref="body_text" placeholder={i18n['Your review']}>{this.state.mine.body}</textarea>
                <button onClick={this.postReview} className="AppButton btn-sm pull-right"><i
                    className={this.state.isReviewing ? "ti-reload" : "ti-pencil"}></i>{i18n.PostReview}</button>
            </div>
        )

    }
});
var BrandProfileReviewsListItem = React.createClass({
    /**
     *
     */
    render: function () {
        return (
            <div className="BrandCard__Follower">
                <img src="https://s-media-cache-ak0.pinimg.com/avatars/tatianamamaeva_1382583329_30.jpg"/>
            </div>
        )

    }
});
var BrandProfileReviewsList = React.createClass({

    /**
     *
     */
    getInitialState: function () {
        return {items: [], isFetching: false, maxPageItems: 10, mine : {}, firstLoadDone : false};
    },
    /**
     *
     */
    fetchItems: function () {
        //
        this.setState({isFetching: true});
        //
        App.Stores.loadData({
            url: App.Routes.brandReviews,
            action: App.Actions.BRAND_REVIEWS_LIST_FETCHING,
            params: {id: this.props.id}
        });
    },
    /**
     *
     */
    componentDidMount: function () {
        App.Dispatcher.attach(App.Actions.BRAND_REVIEWS_LIST_FETCHING, this.onDataChange);
        this.fetchItems();
    },
    /**
     *
     */
    componentWillUnmount: function () {
        App.Dispatcher.detach(App.Actions.BRAND_REVIEWS_LIST_FETCHING, this.onDataChange);
    },
    /**
     *
     */
    onDataChange: function (result) {
        let reviews = result.reviews;
        // my review if i'm connected
        let mine = result.mine;
        let newState = {isFetchingItems: false, mine : mine, firstLoadDone : true};
        // there's more
        if (reviews.length) {
            // update items
            newState['items'] = this.state.items.concat(reviews)
        }
        this.setState(newState);
        // check if there is more results
        if (reviews.length < this.state.maxPageItems) {
            this.setState({noMoreItems: true});
        }
        else {
            this.setState({noMoreItems: false});
        }
    },
    /**
     *
     */
    render: function () {
        var items;
        var bottomLoading = this.state.isFetchingItems ? <Loading/> : "";
        if (this.state.items.length) {
            items = this.state.items.map(function (item, index) {
                return <BrandProfileReviewsListItem entry={item} key={index}/>;
            }.bind(this));
        }
        else {
            if (this.state.isFetchingItems) {
                items = <Fetching />
            }
            else {
                items = <EmptyList />
            }
            bottomLoading = "";
        }
        let editor ;
        if (this.state.firstLoadDone){
            editor = <BrandProfileReviewEdit
                id={this.props.id}
                mine={this.state.mine}
                authenticityToken={this.props.authenticityToken}/>
        }
        else {
            editor = '';
        }
        return (
            <div className="BrandProfile__Reviews">
                {editor}
                <h4>{i18n.Reviews}</h4>
                {items}
                {bottomLoading}
            </div>
        );
    }
});