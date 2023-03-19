import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sallate/layout/shop_app/cubit/shopCubit.dart';
import 'package:Sallate/layout/shop_app/cubit/states.dart';
import 'package:Sallate/shared/components/components.dart';

class FavouritesScreen extends StatefulWidget {
  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is! ShopLodingGetFavouritesState &&
              cubit.favoritesModel!.data!.data!.length > 0,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildListProduct(
              cubit.favoritesModel!.data!.data![index].product,
              context,
            ),
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Divider(
                height: 2,
                color: Colors.grey,
                thickness: 1.5,
              ),
            ),
            itemCount: cubit.favoritesModel!.data!.data!.length,
          ),
          fallback: (context) => SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.pink[400]!,
                      width: 3,
                    ),
                  ),
                  child: Icon(
                    Icons.favorite_outlined,
                    size: 60.0,
                    color: Colors.pink,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  'No Favourites',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 34.0,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () => cubit.changeBottom(0),
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add Some Products',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.add_circle_outline,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
