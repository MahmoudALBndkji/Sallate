import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sallate/shared/styles/themes.dart';
import 'package:Sallate/shared/bloc_observer.dart';
import 'package:Sallate/shared/helper_function.dart';
import 'package:Sallate/layout/shop_app/shopLayout.dart';
import 'package:Sallate/shared/components/constants.dart';
import 'package:Sallate/layout/shop_app/cubit/states.dart';
import 'package:Sallate/modules/login/shop_login_screen.dart';
import 'package:Sallate/layout/shop_app/cubit/shopCubit.dart';
import 'package:Sallate/shared/network/remote/dio_helper.dart';
import 'package:Sallate/shared/network/local/cache_helper.dart';
import 'package:Sallate/modules/OnBoarding_Page/OnBoardingPage.dart';

void main() async {
  // if main is (async) we used this for check for All
  // in Method is executed Then Run This Application
  WidgetsFlutterBinding.ensureInitialized();

  // Handling Custom Show Error
  customError();

  // For Prevent Screen Rotation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  // For Use Token In Api For Test Connection
  print(token);
  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else
    widget = OnBoardingPage();
  runApp(
    MyApp(
      startWidget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  MyApp({
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            home: startWidget,
          );
        },
      ),
    );
  }
}
