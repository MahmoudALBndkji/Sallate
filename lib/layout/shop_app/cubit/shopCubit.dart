import 'package:Sallate/layout/shop_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sallate/models/categories_model.dart';
import 'package:Sallate/models/change_favorites.dart';
import 'package:Sallate/models/favourites_model.dart';
import 'package:Sallate/models/home_model.dart';
import 'package:Sallate/models/login_model.dart';
import 'package:Sallate/modules/categories/categories_screen.dart';
import 'package:Sallate/modules/favourites/favourites_screen.dart';
import 'package:Sallate/modules/products/products_screen.dart';
import 'package:Sallate/modules/settings/settings_screen.dart';
import 'package:Sallate/shared/components/constants.dart';
import 'package:Sallate/shared/network/end_point.dart';
import 'package:Sallate/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favourites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: Home,
      token: token,
    ).then((value) async {
      homeModel = await HomeModel.fromJson(value.data);
      homeModel!.data!.products!.forEach((element) {
        favourites!.addAll({
          element.id!: element.inFavorites!,
        });
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: Categories,
      token: token,
    ).then((value) async {
      categoriesModel = await CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesDataState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int? productId) {
    favourites![productId!] = !favourites![productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: Favourites,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status!)
        favourites![productId] = !favourites![productId]!;
      else
        getFavorites();
    }).catchError((error) {
      favourites![productId] = !favourites![productId]!;
      emit(ShopErrorChangeFavoritesState());
      print(error.toString());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLodingGetFavouritesState());
    DioHelper.getData(
      url: Favourites,
      token: token,
    ).then((value) async {
      favoritesModel = await FavoritesModel.fromJson(value.data);
      // printFullText(value.data.toString());
      emit(ShopSuccessGetFavouritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavouritesState());
    });
  }

  late ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLodingGetUserDataState());
    DioHelper.getData(
      url: Profile,
      token: token,
    ).then((value) async {
      userModel = await ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLodingGetUpdateUserState());
    DioHelper.putData(
      url: updateProfile,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) async {
      userModel = await ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessGetUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUpdateUserState());
    });
  }
}
