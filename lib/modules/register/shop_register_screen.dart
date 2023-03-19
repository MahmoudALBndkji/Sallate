import 'package:Sallate/layout/shop_app/shopLayout.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sallate/modules/register/cubit/cubit.dart';
import 'package:Sallate/modules/register/cubit/states.dart';
import 'package:Sallate/shared/components/components.dart';
import 'package:Sallate/shared/components/constants.dart';
import 'package:Sallate/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {
              // Print For Test
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token;
                navigateReplacementTo(context, ShopLayout());
              });
              showToast(
                message: state.loginModel.message!,
                state: ToastStates.SUCCESS,
              );
            } else {
              // Print For Test
              print(state.loginModel.message);
              showToast(
                message: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopRegisterCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register".toUpperCase(),
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          "Register to browse our hot offers",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                          controller: nameController,
                          prefixIcon: Icons.person_outline,
                          labelText: "User Name",
                          keyboardType: TextInputType.name,
                          validation: (value) {
                            if (value.isEmpty) return "Please Enter Your Name";
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                          controller: emailController,
                          prefixIcon: Icons.email,
                          labelText: "Email Address",
                          keyboardType: TextInputType.emailAddress,
                          validation: (value) {
                            if (value.isEmpty)
                              return "Please Enter Your Email Address";
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                          obscureText: cubit.isPassword,
                          controller: passwordController,
                          prefixIcon: Icons.password,
                          suffixIcon: cubit.suffix,
                          suffixPressed: () => cubit.changePasswordVisibility(),
                          labelText: "Password",
                          keyboardType: TextInputType.visiblePassword,
                          validation: (value) {
                            if (value.isEmpty)
                              return "Please Enter Your Password";
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                          controller: phoneController,
                          prefixIcon: Icons.phone,
                          labelText: "Phone",
                          keyboardType: TextInputType.phone,
                          validation: (value) {
                            if (value.isEmpty) return "Please Enter Your Phone";
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultElevatedButton(
                            text: "register",
                            borderRadius: 15.0,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
