import 'package:Sallate/models/change_favorites.dart';
import 'package:Sallate/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel? model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLodingGetFavouritesState extends ShopStates {
}

class ShopSuccessGetFavouritesState extends ShopStates {}

class ShopErrorGetFavouritesState extends ShopStates {}

class ShopLodingGetUserDataState extends ShopStates {}

class ShopSuccessGetUserDataState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessGetUserDataState(this.loginModel);
}

class ShopErrorGetUserDataState extends ShopStates {}

class ShopLodingGetUpdateUserState extends ShopStates {}

class ShopSuccessGetUpdateUserState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessGetUpdateUserState(this.loginModel);
}

class ShopErrorGetUpdateUserState extends ShopStates {}
