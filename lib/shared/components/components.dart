import 'package:Sallate/models/home_model.dart';
import 'package:Sallate/modules/products/product_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Sallate/layout/shop_app/cubit/shopCubit.dart';
import 'package:Sallate/shared/styles/colors.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateReplacementTo(context, widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => widget));

Widget defaultTextButton({VoidCallback? function, String? text}) => TextButton(
      onPressed: function,
      child: Text("$text".toUpperCase()),
    );

Widget defaultElevatedButton({
  double? height = 50.0,
  double? width = double.infinity,
  VoidCallback? function,
  String? text,
  double? borderRadius = 0.0,
  Color? colorText = Colors.white,
}) =>
    Container(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
            ),
          ),
        ),
        onPressed: function,
        child: Text(
          "$text".toUpperCase(),
          style: TextStyle(
            color: colorText,
          ),
        ),
      ),
    );

Widget defaultElevatedButtonWithIcon({
  double? height = 45.0,
  double? width = 200.0,
  VoidCallback? function,
  Color? backgroundColor = Colors.blue,
  String? text,
  double? borderRadius = 15.0,
  Color? colorText = Colors.white,
  IconData? icon,
}) =>
    Container(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor!,
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            colorText!,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
            ),
          ),
        ),
        onPressed: function,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$text".toUpperCase(),
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Icon(
              icon,
              size: 24.0,
            ),
          ],
        ),
      ),
    );

Widget defaultTextFormField({
  var controller,
  var onSubmit,
  bool obscureText = false,
  TextInputType? keyboardType,
  TextInputAction? action,
  String? labelText,
  String? hintText = "",
  IconData? prefixIcon,
  IconData? suffixIcon,
  VoidCallback? suffixPressed,
  var validation,
  context,
}) =>
    TextFormField(
      onFieldSubmitted: onSubmit,
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      textInputAction: action,
      style: TextStyle(),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(),
        hintText: hintText,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: Padding(
          padding: EdgeInsetsDirectional.only(end: 10.0),
          child: IconButton(
            onPressed: suffixPressed,
            icon: Icon(suffixIcon),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      validator: validation,
    );

void showToast({
  required String message,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates {
  SUCCESS,
  ERROR,
  WARNING,
}

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

Widget buildListProduct(
  model,
  context, {
  bool isOldPrice = true,
}) =>
    Padding(
      padding: EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: CachedNetworkImage(
                    imageUrl: "${model.image}",
                    placeholder: (context, url) => SizedBox(
                      height: 100.0,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    height: 120.0,
                    width: 120,
                  ),
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(100.0),
                      ),
                    ),
                    child: Text(
                      "Discount",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "${model.name}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.3,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${model.price}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            "${model.oldPrice}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                              ShopCubit.get(context).favourites![model.id]!
                                  ? defaultColor
                                  : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget buildGridProduct(ProductModel model, cubit, BuildContext context) =>
    InkWell(
      onTap: () => navigateTo(context, ProductDetails(productModel: model)),
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: CachedNetworkImage(
                    imageUrl: "${model.image}",
                    placeholder: (context, url) => SizedBox(
                      height: 200.0,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    height: 200.0,
                    width: double.infinity,
                  ),
                ),
                if (model.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(100.0),
                      ),
                    ),
                    child: Text(
                      "Discount",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Text(
                    "${model.name}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.3,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${model.price.round()} \$",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            "${model.oldPrice.round()}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          cubit.changeFavorites(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: cubit.favourites[model.id]
                              ? defaultColor
                              : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
