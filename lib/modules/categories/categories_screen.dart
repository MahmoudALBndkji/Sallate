import 'package:Sallate/modules/categories/categories_details.dart';
import 'package:Sallate/shared/components/components.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sallate/layout/shop_app/cubit/shopCubit.dart';
import 'package:Sallate/layout/shop_app/cubit/states.dart';
import 'package:Sallate/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildCategoriesItem(
              cubit.categoriesModel!.data!.data![index], context),
          separatorBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Divider(
              height: 2,
              color: Colors.grey,
              thickness: 1.5,
            ),
          ),
          itemCount: cubit.categoriesModel!.data!.data!.length,
        );
      },
    );
  }

  Widget buildCategoriesItem(DataModel model, context) => Padding(
        padding: EdgeInsets.all(20.0),
        child: InkWell(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
            onTap: () => navigateTo(
              context,
              CategoriesDetails(
                homeModel: ShopCubit.get(context).homeModel,
              ),
            ),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(100),
                        topLeft: Radius.circular(100),
                      ),
                    ),
                  ),
                  CachedNetworkImage(
                    imageUrl: "${model.image}",
                    placeholder: (context, url) => SizedBox(
                      height: 100.0,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    width: 90.0,
                    height: 80.0,
                  ),
                ],
              ),
              SizedBox(
                width: 40.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2,
                ),
                child: Text(
                  "${model.name}",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      );
}
