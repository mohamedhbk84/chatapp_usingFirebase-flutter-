import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newchat/Network/Local/cache_helper.dart';
import 'package:newchat/Shared/component/componentButton.dart';
import 'package:newchat/modules/Cubit/Cubit.dart';
import 'package:newchat/modules/Cubit/States.dart';
import 'package:newchat/modules/HomChat/HomeSocial.dart';
import 'package:newchat/modules/Register/Register.dart';

// ignore: must_be_immutable
class SocialLoginSCreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is LoginErrorStates) {
            showToast(
              text: state.error,
              states: ToastStates.Error,
            );
          }
          if (state is LoginScuessStates) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              navigateAndFinish(
                context,
                HomeSocial(),
              );
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            // appBar: AppBar(
            //   elevation: 0,
            //   backgroundColor: Colors.white,

            //   // title: Text("data"),
            // ),
            body: Container(
              color: Colors.teal.shade600,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                margin: EdgeInsets.only(top: 50, bottom: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red.shade200),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin:
                      EdgeInsets.only(top: 60, right: 10, left: 10, bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white60),
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Form(
                          key: formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Login",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                "Login now to Browser our hot offers",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.grey),
                              ),
                              SizedBox(height: 30),
                              defaultTextField(
                                context: context,
                                controller: emailController,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'ادخل البريد الالكتروني';
                                  } else if (!value.toString().contains('@') ||
                                      !value.toString().contains('.com')) {
                                    return 'ex: example@mail.com';
                                  } else {
                                    return null;
                                  }
                                },
                                onchanege: (String value) {
                                  print(value);
                                },
                                type: TextInputType.emailAddress,
                                label: "Email Address",
                                icon: Icons.email,
                                isShown: false,
                                istrue: false,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              defaultTextField(
                                  context: context,
                                  controller: passwordController,
                                  onsubmit: (value) {
                                    if (formkey.currentState.validate()) {
                                      AppCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "enter the Password";
                                    }
                                    return null;
                                  },
                                  onchanege: (String value) {
                                    print(value);
                                  },
                                  suffixPressed: () {
                                    AppCubit.get(context).changePassword();
                                  },
                                  type: TextInputType.visiblePassword,
                                  label: "Password Address",
                                  icon: Icons.lock_outline,
                                  isShown: AppCubit.get(context).shownPassword,
                                  istrue: true,
                                  suffixicon:
                                      AppCubit.get(context).shownPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                              SizedBox(height: 15),
                              ConditionalBuilder(
                                condition: State is! LoginLoadingStates,
                                builder: (context) => defaultButton(
                                  background: Colors.blue,
                                  function: () {
                                    if (formkey.currentState.validate()) {
                                      AppCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  width: double.infinity,
                                  text: "Login",
                                ),
                                fallback: (context) =>
                                    Center(child: CircularProgressIndicator()),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Dont Have an account ?"),
                                  defaultTextButton(
                                    function: () {
                                      navigateTo(context, RegisterScreen());
                                    },
                                    text: "RegisterIn",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
