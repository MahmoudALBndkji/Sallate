import 'package:Sallate/layout/shop_app/cubit/shopCubit.dart';
import 'package:Sallate/layout/shop_app/cubit/states.dart';
import 'package:Sallate/models/home_model.dart';
import 'package:Sallate/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesDetails extends StatelessWidget {
  HomeModel? homeModel;
  CategoriesDetails({this.homeModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Categories Details"),
          ),
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                color: Colors.grey[300],
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 2.0,
                  childAspectRatio: 1 / 1.65,
                  children: List.generate(
                    homeModel!.data!.products!.length,
                        (index) => buildGridProduct(
                        homeModel!.data!.products![index], cubit, context),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
