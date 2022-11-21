import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/shopCubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            titleSpacing: 0.0,
            title: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 7.0,
                vertical: 3.0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopify_sharp,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text("Sallate"),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () => navigateTo(
                  context,
                  SearchScreen(),
                ),
                icon: Icon(
                  Icons.search,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) => cubit.changeBottom(index),
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: "Categories",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outlined),
                label: "Favorites",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
          ),
        );
      },
    );
  }
}
