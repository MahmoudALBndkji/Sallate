import 'package:Sallate/layout/shop_app/cubit/shopCubit.dart';
import 'package:Sallate/layout/shop_app/cubit/states.dart';
import 'package:Sallate/modules/categories/categories_details.dart';
import 'package:Sallate/modules/products/product_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sallate/models/categories_model.dart';
import 'package:Sallate/models/home_model.dart';
import 'package:Sallate/shared/components/components.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.model!.status!) {
            showToast(
              message: state.model!.message!,
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) => productsBuilder(
              cubit.homeModel, cubit.categoriesModel, cubit, context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel? model, CategoriesModel? categoriesModel,
          var cubit, BuildContext context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    items: model!.data!.banners!
                        .map(
                          (e) => CachedNetworkImage(
                            imageUrl: "${e.image}",
                            placeholder: (context, url) => SizedBox(
                              height: 200.0,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      height: 250.0,
                      initialPage: 0,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(seconds: 1),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoryItem(
                          context, categoriesModel.data!.data![index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10.0,
                      ),
                      itemCount: categoriesModel!.data!.data!.length,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "New Products",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
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
                        model.data!.products!.length,
                        (index) => buildGridProduct(
                            model.data!.products![index], cubit, context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(context, DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          InkWell(
            onTap: () => navigateTo(
              context,
              CategoriesDetails(
                homeModel: ShopCubit.get(context).homeModel,
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: "${model.image}",
              placeholder: (context, url) => SizedBox(
                height: 100.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(.8),
            width: 100.0,
            child: Text(
              "${model.name}",
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}
