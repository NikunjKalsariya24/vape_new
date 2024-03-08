import 'dart:convert';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:vape/model/add_product_model.dart';
import 'package:vape/model/all_order_model.dart';
import 'package:vape/model/banner_model.dart';
import 'package:vape/model/best_selling_model.dart';
import 'package:vape/model/bottom_banner_model.dart';
import 'package:vape/model/category_details_model.dart';
import 'package:vape/model/category_model.dart';
import 'package:vape/model/conversation_chat_model.dart';
import 'package:vape/model/coupon_model.dart';
import 'package:vape/model/create_conversation_model.dart';
import 'package:vape/model/create_message_model.dart';
import 'package:vape/model/custom_popular_model.dart';
import 'package:vape/model/email_logIn_model.dart';
import 'package:vape/model/flsh_sale_model.dart';
import 'package:vape/model/get_coupen_model.dart';
import 'package:vape/model/inwish_list_model.dart';
import 'package:vape/model/login_phone_model.dart';
import 'package:vape/model/logo_model.dart';
import 'package:vape/model/nearest_store_model.dart';
import 'package:vape/model/new_product_model.dart';
import 'package:vape/model/new_shop_model.dart';
import 'package:vape/model/page_view_model.dart';
import 'package:vape/model/people_buy_model.dart';
import 'package:vape/model/popular_product_model.dart';
import 'package:vape/model/produc_remove_model.dart';
import 'package:vape/model/product_details_view_model.dart';
import 'package:vape/model/rating_product_model.dart';
import 'package:vape/model/related_recommended_model.dart';
import 'package:vape/model/search_product_model.dart';
import 'package:vape/model/toggle_wish_list_model.dart';

import 'package:vape/model/user_address_model.dart';
import 'package:vape/model/user_delivery_time_model.dart';
import 'package:vape/model/user_profile_model.dart';
import 'package:vape/model/variations_product_model.dart';
import 'package:vape/model/view_wish_list_model.dart';
import 'package:vape/near_store_product_model.dart';

import 'package:vape/utils/graph_ql_configuration.dart';



class GraphQLService //extends GetxController
{
  static GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  GraphQLClient client = GraphQLConfiguration.client();

  Data? logInPhoneModel;

  MutationOptions<Object?>? options;
  BannerData? bannerModel;
  BottomSliderData? bottomBannerModel;
  CategoriesData? categoryModel;
  BestSellingData? bestSellingModel;
  PopularProductData? popularProductModel;
  PeopleBuyData? peopleBuyModel;
  NewProductData? newProductModel;

  CustomPopularData? customPopularModel;

  LogoData? logoModel;

  // Rx<ToggleWishData?> toggleWishListModel.obs;
  // Rx<ToggleWishData?> toggleWishListModel = Rx<ToggleWishData?>(null);
  ToggleWishData? toggleWishListModel;
  InWishListData? inWishListModel;

  ViewWishListData? viewWishListModel;
  NearestStoreData? nearestStoreModel;
  NewShopModel? newShopModel;
  SearchProductData? searchProductModel;
  AllOrderData? allOrderModel;
  CategoryDetailsData? categoryDetailsModel;
  PageViewData?  pageViewModel;
  CouponData? couponModel;
  CreateConversationData? createConversationModel;


  ConversationChatData? conversationChatModel;

  CreateMessageData? createMessageModel;
  FlashSaleData? flashSaleModel;
  VariationsData?  variationsProductModel;
  AddProductData? addProductModel;
  ProductRemoveData? productRemoveModel;
  ProductDetailsViewData? productDetailsViewModel;
  RelatedRecommendedData? relatedRecommendedModel;
  RatingProductData? ratingProductModel;
  NearStoreProductData? nearStoreProductModel;
  UserProfileData? userProfileModel;
  UserAddressData? userAddressModel;
  GetCouponData? getCouponModel;
  EmailLogInData? emailLogInModel;
  UserDeliveryTimeData? userDeliveryTimeModel;
  Future<bool> getCustomerOtpVerification(String number) async {
    print("client======${client.link}");
    print("client======${client.cache}");
    print("client======${client.defaultPolicies}");
    final MutationOptions options = MutationOptions(
      document: gql('''
        mutation Customeotpverification {
          customeotpverification(input: { number: "$number" }) {
              isContactExist
          }
        }
      '''),
    );

    final QueryResult result = await client.mutate(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final bool isContactExist =
        result.data!['customeotpverification']['isContactExist'];

    return isContactExist;
  }



//   Future<bool> getSocialLogIn(String logInType,String accessToken) async {
//     final MutationOptions options = MutationOptions(
//       document: gql('''
//        mutation SocialLogin {
//     socialLogin(input: { provider: "$logInType", access_token:"$accessToken" }) {
//         token
//         permissions
//         role
//     }
// }
//       '''),
//     );
//
//     final QueryResult result = await client.mutate(options);
//     print("result======${result}");
//     if (result.hasException) {
//       throw Exception(result.exception.toString());
//     }
//
//     // final bool isContactExist =
//     // result.data!['customeotpverification']['isContactExist'];
//
//     // return isContactExist;
//   }


  Future<Data?> otpVerification(
      String name, String email, String number) async {

    print("email===${email}");
    print("email===${number}");
    print("email===${name}");
    if (email.isEmpty && name.isEmpty) {

      print("go to login if");
      options = MutationOptions(
        document: gql('''
        mutation Rcustomeotpverification {
          rcustomeotpverification(input: { number:"$number" }) {
                   token
                   permissions
                   role
          }
        }
      '''),
      );
    }

    else {
      print("go to login else");
      options = MutationOptions(
        document: gql('''
        mutation Rcustomeotpverification {
          rcustomeotpverification(input: { name: "$name" ,email: "$email", number: "$number"}) {
                   token
                   permissions
                   role
          }
        }
      '''),
      );
    }

    final QueryResult result = await client.mutate(options!);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    final Map<String, dynamic>? data = result.data?['rcustomeotpverification'];
    final Map<String, dynamic>? dataGet = result.data;

    if (dataGet == null || dataGet['rcustomeotpverification'] == null) {
      return null;
    }

    logInPhoneModel = Data.fromJson(dataGet);
    // logInPhoneModel = LogInPhoneModel.fromJson(dataGet);

    print(
        "in api logInPhoneModel=====${logInPhoneModel!.rcustomeotpverification!.role}");
    return logInPhoneModel;
  }

  Future<BannerData?> getBanner(String id) async {
    final QueryOptions options = QueryOptions(
      document: gql('''
        query Type {
          type(id: "$id") {
              banners {
                  id
                  title
                  description
                  image {
                      thumbnail
                      original
                      id
                  }
              }
          }
        }
      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");
    bannerModel = BannerData.fromJson(dataGet!);
    print('Bannersinnnnnnnnnnnn ${bannerModel!.type!.banners}');

    return bannerModel;
  }

  Future<BottomSliderData?> getBottomBanner() async {
    final QueryOptions options = QueryOptions(
      document: gql('''
    
query Types {
    types {
        settings {
            isHome
            layoutType
            productCard
            bottomslider {
                thumbnail
                original
                id
            }
        }
    }
}

      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    bottomBannerModel = BottomSliderData.fromJson(dataGet!);
    print('Bannersinnnnnnnnnnnn ${bannerModel!.type!.banners}');

    return bottomBannerModel;
  }

  Future<CategoriesData?> getCategory({
    required String language,
    required int first,
    required int page,
    required String hasTypeValue,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql('''
      
      query Categories {
    categories(
       language: "$language",
        first: $first
        page: $page
        hasType: { value: "$hasTypeValue", column: SLUG, operator:EQ}
        parent: null
    ) {
        data {
            id
            name
            slug
            parent_id
            language
            translated_languages
            products_count
            details
            icon
            created_at
            updated_at
            image {
                thumbnail
                original
                id
            }
        }
    }
}
      
      
 
      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("categoryModelview$dataGet");

    categoryModel = CategoriesData.fromJson(dataGet!);

    return categoryModel;
  }

  Future<BestSellingData?> bestSellingProduct(String token) async {
    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
  query BestSellingProducts {
    bestSellingProducts {
        id
        name
        slug
        language
        translated_languages
        product_type
        shop_id
        author_id
        manufacturer_id
        blocked_dates
        description
        in_stock
        is_taxable
        is_digital
        is_external
        external_product_url
        external_product_button_text
        sale_price
        max_price
        min_price
        ratings
        total_reviews
        in_wishlist
        sku
        status
        height
        length
        width
        price
        quantity
        unit
        sold_quantity
        in_flash_sale
        created_at
        updated_at
        image {
            thumbnail
            original
            id
        }
    }
}
      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    bestSellingModel = BestSellingData.fromJson(dataGet!);

    return bestSellingModel;
  }

  Future<PopularProductData?> popularProduct(String token) async {
    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
  query PopularProducts {
    popularProducts {
        id
        name
        slug
        language
        translated_languages
        product_type
        shop_id
        author_id
        manufacturer_id
        blocked_dates
        description
        in_stock
        is_taxable
        is_digital
        is_external
        external_product_url
        external_product_button_text
        sale_price
        max_price
        min_price
        ratings
        total_reviews
        in_wishlist
        sku
        status
        height
        length
        width
        price
        quantity
        unit
        sold_quantity
        qtn
        in_flash_sale
        created_at
        updated_at
        image {
            thumbnail
            original
            id
        }
    }
}
      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    popularProductModel = PopularProductData.fromJson(dataGet!);
    print('popularProductModel ${popularProductModel!.popularProducts}');

    return popularProductModel;
  }

  Future<PeopleBuyData?> peopleBuy(String token, String type) async {
    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''



query Types {
    types(text:"$type") {
        id
        name
        language
        translated_languages
        slug
        icon
        created_at
        updated_at
        settings {
            isHome
            layoutType
            productCard
            handpickedProducts {
                enable
                title
                enableSlider
                products {
                    id
                    slug
                    name
                    regular_price
                    sale_price
                    min_price
                    max_price
                    product_type
                    quantity
                    is_external
                    unit
                    price
                    external_product_url
                    status
                    image {
                        thumbnail
                        original
                        id
                    }
                }
            }
        }
    }
}
      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    peopleBuyModel = PeopleBuyData.fromJson(dataGet!);

    return peopleBuyModel;
  }

  Future<NewProductData?> newProduct(
      String token, int first, String language) async {
    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
 query Products {
    products(
        first: $first
        language: "$language"
        orderBy: "created_at"
        search: "type.slug:grocery;status:publish"
        searchJoin: "AND"
        sortedBy: "DESC"
    ) {
        data {
            id
            name
            slug
            language
            translated_languages
            product_type
            shop_id
            author_id
            manufacturer_id
            blocked_dates
            description
            in_stock
            is_taxable
            is_digital
            is_external
            external_product_url
            external_product_button_text
            sale_price
            max_price
            min_price
            ratings
            total_reviews
            in_wishlist
            sku
            status
            height
            length
            width
            price
            quantity
            unit
            sold_quantity
            in_flash_sale
            created_at
            updated_at
            image {
                thumbnail
                original
                id
            }
        }
        paginatorInfo {
            count
            currentPage
            firstItem
            hasMorePages
            lastItem
            lastPage
            perPage
            total
        }
    }
}
      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    newProductModel = NewProductData.fromJson(dataGet!);

    return newProductModel;
  }

  Future<CustomPopularData?> customPopularProduct(
      String id, String token) async {
    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
    query Types {
    types {
        id
        name
        language
        translated_languages
        slug
        icon
        created_at
        updated_at
        settings {
            isHome
            layoutType
            productCard
            customeproduct {
                title
                category
                products {
                    id
                    slug
                    name
                    regular_price
                    sale_price
                    min_price
                    max_price
                    product_type
                    quantity
                    is_external
                    unit
                    price
                    external_product_url
                    status
                    image {
                        thumbnail
                        original
                        id
                    }
                }
            }
        }
    }
}
      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    customPopularModel = CustomPopularData.fromJson(dataGet!);

    return customPopularModel;
  }

  Future<LogoData?> logo() async {
    final QueryOptions options = QueryOptions(
      document: gql('''
 query Settings {
    settings {
        options {
            logo {
                thumbnail
                original
                id
            }
        }
    }
}


      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    logoModel = LogoData.fromJson(dataGet!);
    print(
        'popularProductModel ${logoModel!.settings!.options!.logo!.thumbnail}');

    return logoModel;
  }

  Future<ToggleWishData?> wishListToggle(String productId, String token) async {
    GraphQLConfiguration.setAuthToken(token);

    print("productId====$productId");
    options = MutationOptions(
      document: gql('''
        mutation ToggleWishlist {
    toggleWishlist(input: { product_id: $productId })
}
      '''),
    );

    final QueryResult result = await client.mutate(options!);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    toggleWishListModel = ToggleWishData.fromJson(dataGet!);
    print('customPopularModel ${toggleWishListModel!.toggleWishlist}');

    return toggleWishListModel;
  }

  Future<InWishListData> inWishList(String productId, String token) async {
    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
      
query In_wishlist {
    in_wishlist(product_id: $productId)
}


      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");
    InWishListData? inWishListModel;

    inWishListModel = InWishListData.fromJson(dataGet!);
    print('popularProductModel ${inWishListModel.inWishlist}');

    return inWishListModel;
  }

  Future<ViewWishListData?> viewWishList(String token,int first,int page) async {
    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
query Wishlists {
wishlists(first: $first, page: $page) {
paginatorInfo {
count
currentPage
firstItem
hasMorePages
lastItem
lastPage
perPage
total
}
data {
id
name
slug
language
translated_languages
product_type
shop_id
author_id
manufacturer_id
blocked_dates
description
in_stock
is_taxable
is_digital
is_external
external_product_url
external_product_button_text
sale_price
max_price
min_price
ratings
total_reviews
in_wishlist
sku
status
height
length
width
price
quantity
unit
sold_quantity
in_flash_sale
qtn
created_at
updated_at
  image {
                thumbnail
                original
                id
            }
}
}
}

      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    viewWishListModel = ViewWishListData.fromJson(dataGet!);

    print('viewWishListModel ${viewWishListModel!.wishlists!.data!.length}');

    return viewWishListModel;
  }

  Future<NearestStoreData?> nearestStore(String id, String token) async {
    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
query Shop {
    shop(id: "$id") {
        id
        owner_id
        is_active
        orders_count
        products_count
        name
        slug
        description
        distance
        lat
        lng
        created_at
        updated_at
    }
}
      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    nearestStoreModel = NearestStoreData.fromJson(dataGet!);

    print('viewWishListModel${viewWishListModel!.wishlists!.data!.length}');

    return nearestStoreModel;
  }

  Future<SearchProductData?> searchProduct(
      String token, int first, String language, String search) async {
    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
      
      query Products {
    products(
        first: $first
        language: "$language"
        search: "name:$search;status:publish"
        searchJoin: "AND"
    ) {
       data {
            id
            name
            slug
            language
            translated_languages
            product_type
            shop_id
            author_id
            manufacturer_id
            blocked_dates
            description
            in_stock
            is_taxable
            is_digital
            is_external
            external_product_url
            external_product_button_text
            sale_price
            max_price
            min_price
            ratings
            total_reviews
            in_wishlist
            sku
            status
            height
            length
            width
            price
            quantity
            unit
            sold_quantity
            in_flash_sale
            created_at
            updated_at
            image {
                thumbnail
                original
                id
            }
            gallery {
                thumbnail
                original
                id
            }
            video {
                url
            }
            related_products {
                id
                name
                slug
                language
                translated_languages
                product_type
                shop_id
                author_id
                manufacturer_id
                blocked_dates
                description
                in_stock
                is_taxable
                is_digital
                is_external
                external_product_url
                external_product_button_text
                sale_price
                max_price
                min_price
                ratings
                total_reviews
                in_wishlist
                sku
                status
                height
                length
                width
                price
                quantity
                unit
                sold_quantity
                in_flash_sale
                created_at
                updated_at
            }
            variation_options {
                id
                title
                language
                price
                blocked_dates
                sku
                is_disable
                is_digital
                sale_price
                quantity
                sold_quantity
            }
            variations {
                id
                value
                meta
                attribute_id
                language
            }
        }
        paginatorInfo {
            count
            currentPage
            firstItem
            hasMorePages
            lastItem
            lastPage
            perPage
            total
        }
    }
}

      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    //   print("dataGet=====${dataGet}");

    searchProductModel = SearchProductData.fromJson(dataGet!);

    print('viewWishListModel${searchProductModel!.products!.data!.length}');

    return searchProductModel;
  }

  Future<dynamic> nearShop(String? lat, String? long) async {
    print("long=-===$long");
    print("lat=-===$lat");
    var url = Uri.parse("https://4pay.ai/backend/near-by-shop/$lat/$long");
    print("url=======$url");
    var response = await http.get(url);

    print("nearShopData=====${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> nearShopData = jsonDecode(response.body);

      print("nearShopData=====$nearShopData");
      // nearShopDataView.length;
      // return nearShopDataView;
      // newShopModel = NewShopModel.fromJson(nearShopData)
      //List<dynamic> data = jsonDecode(response.body);
      return List<NewShopModel>.from(
          nearShopData.map((model) => NewShopModel.fromJson(model)));
      return nearShopData.cast<Map<String, dynamic>>().toList();
      // newShopModel = NewShopModel.fromJson(nearShopData);

      return newShopModel;
    } else {
      throw Exception('Failed to load shop data');
      return newShopModel;
    }
  }

  Future<AllOrderData?> allOrder(
      String token, int first, String customerId) async {
    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
      
    query Orders {
    orders(first: $first, customer_id:$customerId) {
        data {
            id
            tracking_number
            customer_id
            customer_contact
            customer_name
            language
            parent_id
            order_status
            payment_status
            amount
            sales_tax
            total
            paid_total
            payment_id
            payment_gateway
            altered_payment_gateway
            discount
            delivery_fee
            delivery_time
            created_at
            updated_at
            note
        }
    }
}

      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    //   print("dataGet=====${dataGet}");

    allOrderModel = AllOrderData.fromJson(dataGet!);

    print('viewWishListModel${allOrderModel!.orders!.data!.length}');

    return allOrderModel;
  }

  Future<CategoryDetailsData?> categoryDetails(
      String token, String slug) async {
    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
  query Products {
categories(name: "$slug") {
data {
products {
id
name
slug
language
translated_languages
product_type
shop_id
author_id
manufacturer_id
blocked_dates
description
in_stock
is_taxable
is_digital
is_external
external_product_url
external_product_button_text
sale_price
max_price
min_price
ratings
total_reviews
in_wishlist
sku
status
height
length

width
price
quantity
unit
sold_quantity
in_flash_sale
created_at
updated_at
image {
thumbnail
original
id
}
gallery {
thumbnail
original
id
}
categories {
name
}
}
}
}
}
      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    categoryDetailsModel = CategoryDetailsData.fromJson(dataGet!);

    return categoryDetailsModel;
  }

  Future<PageViewData?> getStartDetails(
      String id) async {


    final QueryOptions options = QueryOptions(
      document: gql('''
       query Type {
          type(id: "$id") {
           settings {
          pageViews
           }
           }
           }
      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    pageViewModel = PageViewData.fromJson(dataGet!);

    return pageViewModel;
  }

  Future<CouponData?> couponGet(
      String token, int first,String language) async {

    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
            query Coupons {
    coupons(first:$first,language:"$language") {
        data {
            id
            code
            description
            type
            language
            translated_languages
            is_valid
            message
            amount
            minimum_cart_amount
            sub_total
            active_from
            expire_at
            created_at
            updated_at
            target
            is_approve
            shop_id
            user_id
            image {
                thumbnail
                original
                id
            }
        }
    }
}
      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    couponModel = CouponData.fromJson(dataGet!);

    return couponModel;
  }


  Future<CreateConversationData?> createConversation(String token,String shopId) async {
    GraphQLConfiguration.setAuthToken(token);
    final MutationOptions options = MutationOptions(
      document: gql('''
    mutation CreateConversation {
             createConversation(input: { shop_id:"$shopId"}) {
                             id
                             user_id
                             shop_id
                             unseen
                             created_at
                             updated_at
                                   }
                                }
                                 '''),
    );

    final QueryResult result = await client.mutate(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    createConversationModel = CreateConversationData.fromJson(dataGet!);

    return createConversationModel;
  }





  Future<ConversationChatData?> getConversation(String token,String conversationId) async {
    GraphQLConfiguration.setAuthToken(token);
    final MutationOptions options = MutationOptions(
      document: gql('''
   query Messages {
messages(conversation_id: "$conversationId") {
data {
id
user_id
conversation_id
body
created_at
updated_at
}
}
}
'''),
    );

    final QueryResult result = await client.mutate(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    conversationChatModel = ConversationChatData.fromJson(dataGet!);

    return conversationChatModel;
  }



  Future<CreateMessageData?> createMassage(String token,String conversationId,String massageGet) async {
    print("token====$token");
    print("token====$conversationId");
    print("token====$massageGet");

    GraphQLConfiguration.setAuthToken(token);
    final MutationOptions options = MutationOptions(
      document: gql('''
mutation CreateMessage {
createMessage(input: { conversation_id: $conversationId, message: "$massageGet" }) {
id
user_id
conversation_id
body
created_at
updated_at
}
}
'''),
    );

    final QueryResult result = await client.mutate(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    createMessageModel = CreateMessageData.fromJson(dataGet!);

    return createMessageModel;
  }


  Future<FlashSaleData?> flashSaleGet(
      String token) async {

    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
  query FlashSale {
flashSales {
data {
id
title
slug
description
start_date
end_date
sale_status
type
rate
language
translated_languages
deleted_at
created_at
updated_at
}
}
}
      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    flashSaleModel = FlashSaleData.fromJson(dataGet!);

    return flashSaleModel;
  }



  Future<VariationsData?> variationsProduct(
      String token,String productId) async {

    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
query Product {
product(id: "$productId") {
variations {
attribute_id
meta
value
attribute {
name
}
}
}
}
      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    variationsProductModel = VariationsData.fromJson(dataGet!);

    return variationsProductModel;
  }



  Future<AddProductData?> addToCartProduct(String productId) async {


    final MutationOptions options = MutationOptions(
      document: gql('''
     mutation AddtocartProduct {
AddtocartProduct(input: { productid: "${productId}" })
}
      '''),
    );

    final QueryResult result = await client.mutate(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    addProductModel = AddProductData.fromJson(dataGet!);

    return addProductModel;
  }

  Future<ProductRemoveData?> cartProductRemove(String productId) async {
    final MutationOptions options = MutationOptions(
      document: gql('''
   mutation AddtocartProductRemove {
AddtocartProductRemove(input: { productid: "${productId}" })
}
      '''),
    );

    final QueryResult result = await client.mutate(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    productRemoveModel = ProductRemoveData.fromJson(dataGet!);

    return productRemoveModel;
  }


  Future<ProductDetailsViewData?> productDetailsView(
      String token, String productId,String productSlug,String language) async {

    print("productId===${productId}");
    print("productSlug===${productSlug}");

    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
  query Product {
product(id: "${productId}", slug: "$productSlug", language: "${language}") {
id
name
slug
image {
thumbnail
original
id
}
description
unit
sale_price
categories {
id
name
slug
parent_id
language
translated_languages
products_count
details
icon
created_at
updated_at
}
gallery {
thumbnail
original
id
}
shop {
id
owner_id
is_active
orders_count
products_count
name
slug
description
distance
lat
lng
created_at
updated_at
}
variation_options {
id
title
language
price
blocked_dates
sku
is_disable
is_digital
sale_price
quantity
sold_quantity
}
variations {
id
value
meta
attribute_id
language
}
ratings
attributeslist {
key
data {
av_id
av_value
attribute_id
}
}
max_price
}
}
      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    productDetailsViewModel = ProductDetailsViewData.fromJson(dataGet!);

    return productDetailsViewModel;
  }
  Future<ProductDetailsViewData?> productReviewGet(
      String token, int first,int page,String productId) async {
    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
 query Reviews {
    reviews(first: $first, page: $page, product_id: "${productId}") {
        data {
            id
            comment
            rating
            user_id
            order_id
            product_id
            variation_option_id
            shop_id
            positive_feedbacks_count
            negative_feedbacks_count
            abusive_reports_count
            created_at
            updated_at
        }
        paginatorInfo {
            count
            currentPage
            firstItem
            hasMorePages
            lastItem
            lastPage
            perPage
            total
        }
    }
}
      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    productDetailsViewModel = ProductDetailsViewData.fromJson(dataGet!);

    return productDetailsViewModel;
  }


  Future<RelatedRecommendedData?> relatedRecommendedProduct(
      String token, String slug) async {
    print("slug====${slug}");
    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
query Product {
    product(slug: "$slug") {
        related_products {
            id
            name
            slug
            language
            translated_languages
            product_type
            shop_id
            author_id
            manufacturer_id
            blocked_dates
            description
            in_stock
            is_taxable
            is_digital
            is_external
            external_product_url
            external_product_button_text
            sale_price
            max_price
            min_price
            ratings
            total_reviews
            in_wishlist
            sku
            status
            height
            length
            width
            price
            quantity
            unit
            sold_quantity
            in_flash_sale
            created_at
            updated_at
            image {
                thumbnail
                original
                id
            }
        }
    }
}

      '''),
    );

    // final QueryResult result = await client.query(options);
    // print("result======$result");
    // if (result.hasException) {
    //   throw Exception(result.exception.toString());
    // }
    //
    // var dataGet = result.data;
    //
    // print("dataGet=====$dataGet");
    //
    // relatedRecommendedModel = RelatedRecommendedData.fromJson(dataGet!);
    //
    // return relatedRecommendedModel;
    try {
      final QueryResult result = await client.query(options);
      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      var dataGet = result.data;

      print("dataGet=====$dataGet");

      relatedRecommendedModel = RelatedRecommendedData.fromJson(dataGet!);
      return relatedRecommendedModel;
    } catch (e) {
      print("Error fetching related products: $e");
      return null;
    }

  }

  Future<RatingProductData?> ratingProduct(
      String token, int first,int page,String productId) async {
    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
query Reviews {
reviews(first: $first, page: $page, product_id: "$productId") {
        data {
            id
            comment
            rating
            user_id
            order_id
            product_id
            variation_option_id
            shop_id
            positive_feedbacks_count
            negative_feedbacks_count
            abusive_reports_count
            created_at
            updated_at
            user {
                profile {
                    id
                    bio
                    contact
                    avatar {
                        thumbnail
                        original
                        id
                    }
                }
                name
                created_at
                updated_at
            }
            photos {
                thumbnail
                original
                id
            }
        }
        paginatorInfo {
            count
            currentPage
            firstItem
            hasMorePages
            lastItem
            lastPage
            perPage
            total
        }
    }
}


      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    ratingProductModel = RatingProductData.fromJson(dataGet!);

    return ratingProductModel;
  }



  Future<NearStoreProductData?> nearStoreProduct(
      String token,int shopId) async {
    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
query Products {
products(search: "shop_id:$shopId") {
data {
id
name
slug
language
translated_languages
product_type
shop_id
author_id
manufacturer_id
blocked_dates
description
in_stock
is_taxable
is_digital
is_external
external_product_url
external_product_button_text
sale_price
max_price
min_price
ratings
total_reviews
in_wishlist
sku
status
height
length
width
price
quantity
unit
sold_quantity
in_flash_sale
qtn
created_at
updated_at
variation_options {
id
title
language
price
blocked_dates
sku
is_disable
is_digital
sale_price
quantity
sold_quantity
}
variations {
id
value
meta
attribute_id
language
}
image {
thumbnail
original
id
}
gallery {
thumbnail
original
id
}
video {
url
}
my_review {
id
comment
rating
user_id
order_id
product_id
variation_option_id
shop_id
positive_feedbacks_count
negative_feedbacks_count
abusive_reports_count
created_at
updated_at
}
rating_count {
rating
total
}
related_products {
id
name
slug
language
translated_languages
product_type
shop_id
author_id
manufacturer_id
blocked_dates
description
in_stock
is_taxable
is_digital
is_external
external_product_url
external_product_button_text
sale_price
max_price
min_price
ratings
total_reviews
in_wishlist
sku
status
height
length
width
price
quantity
unit
sold_quantity
in_flash_sale
qtn
created_at
updated_at
}
author {
id
name
is_approved
language
translated_languages
slug
bio
quote
products_count
born
death
languages
created_at
updated_at
}
orders {
id
tracking_number
customer_id
customer_contact
customer_name
language
parent_id
order_status
payment_status
amount
sales_tax
total
paid_total
payment_id
payment_gateway
altered_payment_gateway
discount
delivery_fee
delivery_time
created_at
updated_at
note
}
categories {
id
name
slug
parent_id
language
translated_languages
products_count
details
icon
created_at
updated_at
}
}
paginatorInfo {
count
currentPage
firstItem
hasMorePages
lastItem
lastPage
perPage
total
}
}
}

      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    nearStoreProductModel = NearStoreProductData.fromJson(dataGet!) ;

    return nearStoreProductModel;
  }
  Future<bool> logOut() async {

    final MutationOptions options = MutationOptions(
      document: gql('''
     mutation Logout {
    logout
}
      '''),
    );

    final QueryResult result = await client.mutate(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final bool isLogout =
    result.data!['logout'];

    return isLogout;
  }






  Future<UserProfileData?> getUserProfile(String token) async {

    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
query Me {
me {
id
name
email
shop_id
notification_token
created_at
updated_at
permissions {
id
name
}
is_active
address {
id
title
default
type
}
profile {
id
bio
contact
avatar {
thumbnail
original
id
}
notifications {
email
enable
}
}
}
}
      '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    userProfileModel = UserProfileData.fromJson(dataGet!);

    return userProfileModel;
  }



  Future<UserAddressData?> getUserAddress(String token) async {

    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
query Me {
me {
address {
id
title
default
type
address {
street_address
country
city
state
zip
}
location {
lat
lng
street_number
route
street_address
city
state
country
zip
formattedAddress
}
}
}
}
   '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    userAddressModel = UserAddressData.fromJson(dataGet!);

    return userAddressModel;
  }

  Future<String> addAddress(String token,String title,String userId,String streetAddress,String city,String state,String country,String zip) async {
    GraphQLConfiguration.setAuthToken(token);
    final MutationOptions options = MutationOptions(
      document: gql('''
mutation UpdateUser {
    updateUser(
        input: {
            id: "$userId"
            address: {
                upsert: [
                    {
                        title: "$title"
                        type: BILLING
                        address: {
                            country: "$country"
                            city: "$city"
                            state: "$state"
                            zip: "$zip"
                            street_address: "$streetAddress"
                        }
                  
                    }
                ]
            }
        }
    ) {
        id
    }
}

      '''),
    );

    final QueryResult result = await client.mutate(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final String newUserId =
    result.data!['updateUser']['id'];

    return newUserId;
  }

  Future<String> removeAddress(String token,String addressId) async {
    GraphQLConfiguration.setAuthToken(token);
    final MutationOptions options = MutationOptions(
      document: gql('''
mutation DeleteAddress {
deleteAddress(id: "$addressId") {
id
title
default
}
}
      '''),
    );

    final QueryResult result = await client.mutate(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final String removeAddressId =
    result.data!['deleteAddress']['id'];

    return removeAddressId;
  }


  Future<String> updateAddress(String token,String userId,String addressId,String title,String streetAddress,String city,String state,String country,String zip) async {
print("update address");
    print("${token}");
    print("${userId}");
    print("${addressId}");
    print("${title}");
    print("${streetAddress}");
    print("${city}");
    print("${state}");
    print("${country}");
    print("${zip}");
    GraphQLConfiguration.setAuthToken(token);
    final MutationOptions options = MutationOptions(
      document: gql('''
mutation UpdateUser {
updateUser(input: { id: "$userId", address: { upsert: [
{
id:"$addressId"
title:"$title",
type:BILLING,
address:{
country:"$country",
city:"$city",
state:"$state",
zip:"$zip",
street_address:"$streetAddress"
}
location:{
lat:-17.4023175,
lng:-66.1540478,
formattedAddress:"Punata, Cochabamba, Bolivia",
street_address:"punagam",
city:"surat",
state:"gujarat",
country:"india"
}
}
] } }) {
id
}
}
      '''),
    );

    final QueryResult result = await client.mutate(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
print("userData======${result.data!}");
    final String updateUserId =
    result.data!['updateUser']['id'];
print("updateUserId=====${updateUserId}");
    return updateUserId;
  }



  Future<GetCouponData?> getCoupon(String token) async {

    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
query Coupons {
coupons {
data {
id
code
description
type
language
translated_languages
is_valid
message
amount
minimum_cart_amount
sub_total
active_from
expire_at
created_at
updated_at
target
is_approve
shop_id
user_id
}
}
}
   '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    getCouponModel = GetCouponData.fromJson(dataGet!);

    return getCouponModel;
  }

  Future<bool> appEmailCheck(String email) async {
    print("in to log in$email");
    final MutationOptions options = MutationOptions(
      document: gql('''
        mutation Appemailchack {
          appemailchack(email: "$email") {
            isContactExist
          }
        }
      '''),
    );

    final QueryResult result = await client.mutate(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    print("userData======${result.data!}");
    bool appEmailVerify = result.data!['appemailchack']['isContactExist'];
    print("updateUserId=====${appEmailVerify}");
    return appEmailVerify;
  }

  Future<EmailLogInData?> appEmailLogIn(String email, String name, bool appEmailVerify) async {
    MutationOptions options;

    if (appEmailVerify == true) {
      options = MutationOptions(
        document: gql('''
          mutation appemaillogin  {
            appemaillogin(input: { email: "$email" }) {
              token
              permissions
              role
            }
          }
        '''),
      );
    } else {
      options = MutationOptions(
        document: gql('''
          mutation appemaillogin {
            appemaillogin(input: { email: "$email", name: "$name" }) {
              token
              permissions
              role
            }
          }
        '''),
      );
    }

    final QueryResult result = await client.mutate(options!);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    var dataGet = result.data;
    print("userData======${result.data!}");
    emailLogInModel = EmailLogInData.fromJson(dataGet!);

    return emailLogInModel;
  }





  Future<UserDeliveryTimeData?> userDeliveryTime(String token) async {

    GraphQLConfiguration.setAuthToken(token);

    final QueryOptions options = QueryOptions(
      document: gql('''
query Settings {
settings(language: "en") {
id
language
options {
deliveryTime {
title
slug
language
translated_languages
description
icon
created_at
updated_at
}
}
}
}
   '''),
    );

    final QueryResult result = await client.query(options);
    print("result======$result");
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    var dataGet = result.data;

    print("dataGet=====$dataGet");

    userDeliveryTimeModel = UserDeliveryTimeData.fromJson(dataGet!);

    return userDeliveryTimeModel;
  }
}
