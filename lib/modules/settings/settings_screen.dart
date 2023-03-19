import 'package:Sallate/layout/shop_app/cubit/shopCubit.dart';
import 'package:Sallate/layout/shop_app/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sallate/shared/components/components.dart';
import 'package:Sallate/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessGetUpdateUserState)
          showToast(
            message: state.loginModel.message!,
            state: ToastStates.SUCCESS,
          );
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        nameController.text = cubit.userModel!.data!.name!;
        emailController.text = cubit.userModel!.data!.email!;
        phoneController.text = cubit.userModel!.data!.phone!;
        return ConditionalBuilder(
          condition: cubit.userModel != null,
          builder: (context) => Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    if (state is ShopLodingGetUpdateUserState)
                      LinearProgressIndicator(
                        color: Colors.blue,
                        backgroundColor: Colors.green,
                      ),
                    SizedBox(
                      height: 30.0,
                    ),
                    defaultTextFormField(
                      context: context,
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validation: (value) {
                        if (value.isEmpty) return 'name must not be empty';
                      },
                      labelText: "Name",
                      prefixIcon: Icons.person,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    defaultTextFormField(
                      context: context,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validation: (value) {
                        if (value.isEmpty) return 'email must not be empty';
                      },
                      labelText: "Email Address",
                      prefixIcon: Icons.email_outlined,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    defaultTextFormField(
                      context: context,
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validation: (value) {
                        if (value.isEmpty) return 'phone must not be empty';
                      },
                      labelText: "Phone",
                      prefixIcon: Icons.phone_outlined,
                    ),
                    SizedBox(
                      height: 60.0,
                    ),
                    defaultElevatedButtonWithIcon(
                      text: "Update",
                      function: () {
                        if (formKey.currentState!.validate())
                          cubit.updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                      },
                      icon: Icons.update,
                      backgroundColor: Colors.green[500],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    defaultElevatedButtonWithIcon(
                      text: "logout",
                      function: () {
                        signOut(context);
                        showToast(
                          message: "Logout Successfully",
                          state: ToastStates.ERROR,
                        );
                      },
                      icon: Icons.logout_outlined,
                      backgroundColor: Colors.red[500],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
