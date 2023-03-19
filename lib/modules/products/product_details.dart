import 'package:Sallate/layout/shop_app/cubit/shopCubit.dart';
import 'package:Sallate/layout/shop_app/cubit/states.dart';
import 'package:Sallate/models/home_model.dart';
import 'package:Sallate/shared/styles/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatelessWidget {
  ProductModel? productModel;

  ProductDetails({this.productModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Information Details"),
            centerTitle: true,
          ),
          body: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                color: Colors.grey[200],
                child: Text(
                  "${productModel!.name}",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 3.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.transparent,
                        Colors.white.withOpacity(0.8),
                        Colors.grey.withOpacity(0.2),
                      ], begin: Alignment.topRight, end: Alignment.bottomRight),
                      // color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                  ),
                  CachedNetworkImage(
                    imageUrl: "${productModel!.image}",
                    placeholder: (context, url) => SizedBox(
                      height: 200.0,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    height: 200.0,
                    width: double.infinity,
                  ),
                  if (productModel!.discount != 0)
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.5,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red[600],
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(100.0),
                        ),
                      ),
                      child: Text(
                        "Discount",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.4),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(5.0),
                    bottomRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(5.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      offset: Offset(2.0, 2.0),
                    )
                  ],
                ),
                height: 200.0,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Text(
                    "${productModel!.description}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                              15.0,
                              5.0,
                              15.0,
                              3.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.green[700]!,
                                  width: 3.0,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "${productModel!.price}",
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 7.0,
                                ),
                                Icon(
                                  Icons.monetization_on_outlined,
                                  color: Colors.green[700],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (productModel!.discount != 0) Spacer(),
                    if (productModel!.discount != 0)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          "${productModel!.oldPrice.round()}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      ShopCubit.get(context).favourites![productModel!.id] ??
                              false
                          ? defaultColor
                          : Colors.grey,
                  padding: EdgeInsets.all(10.0),
                  shape: CircleBorder(),
                ),
                onPressed: () => cubit.changeFavorites(productModel!.id),
                child: Icon(
                  Icons.favorite_border,
                  size: 50.0,
                  color: Colors.white,
                  // backgroundColor: ShopCubit.get(context).favourites![productModel!.id]
                  //     ? defaultColor
                  //     : Colors.grey,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
