
/**
 *
 * @type {string}
 */
var baseApiUrl = "/api/v1/";
/**
 * All dashboard js routes
 * @type {{info: string}}
 */
App.DashboradRoutes = {
    stats: '/dashboard/ajax/stats',
    galleryList: '/dashboard/gallery',
    collections: '/dashboard/collections',
    collectionsItemAdd : '/dashboard/collections/:id/add-products',
    collectionsItemRemove : '/dashboard/collections/:id/remove-products'
};
/**
 *
 */
var routes = {
    categories: 'categories',
    geoAddress: 'geo/address',
    geoSearch: 'geo/search',
    geoMine: 'geo/mine',
    brands: 'brands',
    showBrand: 'brands/:id',
    brandInfo: 'brands/:id/info',
    brandFollowers: 'brands/:id/followers',
    brandProducts: 'brands/:id/products',
    // @deprecated use locations
    brandStores: 'brands/:id/stores',
    brandLocations : 'brands/:id/stores',
    followBrand: 'brands/:id/follow',
    unFollowBrand: 'brands/:id/unfollow',
    // reviews

    brandReviews: 'brands/:id/reviews',

    products: 'products',
    productOfDay: 'products/product-of-day',
    wishProduct: 'products/:id/wish',
    unWishProduct: 'products/:id/unwish',
    voteProduct: 'products/:id/vote',
    unVoteProduct: 'products/:id/unvote',
    showProduct: 'products/:id/',
    notifyProduct: 'products/:id/notify',
    productWishers: 'products/:id/wishers',
    productStores: 'products/:id/stores',
    productReviews: 'products/:id/reviews',
    productCoupons: 'products/:id/coupons',
    shareProduct: 'products/:id/share',
    search: 'search',
    userProfile: 'users/:id',
    userBrands: 'users/:id/brands',
    userFollowers: 'users/:id/followers',
    userFollowing: 'users/:id/following',
    userWishes: 'users/:id/wishes'
};
/**
 *
 * @type {{}}
 */
App.Routes = {};
/**
 *
 */
for (var key in routes) {
    App.Routes[key] = baseApiUrl + routes[key];
}