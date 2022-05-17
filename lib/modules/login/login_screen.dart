import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../layout/shop_layout.dart';
import '../../shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
          builder: (context,state){
            var cubit=LoginCubit.get(context);
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'LOGIN',
                            style: TextStyle(
                                fontSize: 40.0,
                                color: Colors.green),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          const Text(
                            'Login now to browse our hot offers',
                            style: TextStyle(
                                fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey
                            ),
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                          defaultTextFormFiled(
                              controller: emailController,
                              prefixIcon: Icons.email_outlined,
                              label: 'Email address',
                              textInputType: TextInputType.emailAddress,
                              onSubmit: (String value){
                                if(formKey.currentState!.validate()){
                                  return '';
                                }
                                return null;
                              },
                              validator: (String? value){
                                if(value!.isEmpty){
                                  return 'Invalid email address';
                                }
                                return null;
                              }),
                           const SizedBox(
                            height: 20.0,
                          ),
                          defaultTextFormFiled(
                              controller: passwordController,
                              prefixIcon: Icons.lock_outline,
                              suffixIcon: cubit.suffixIcon,
                              onSuffixIconTap: (){
                                  cubit.changePasswordVisibility();
                              },
                              label: 'Password',
                              onSubmit: (String value){
                                if(formKey.currentState!.validate()){
                                  cubit.userLogin(email: emailController.text, password: passwordController.text);
                                }
                                return null;
                              },
                              textInputType: TextInputType.visiblePassword,
                              obscureType: cubit.isPassword,
                              validator: (String? value){
                                if(value!.isEmpty){
                                  return 'Invalid password';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 40.0,
                          ),
                          ConditionalBuilder(
                            condition: state is LoginUserLoadingState,
                            builder: (context)=>const Center(child: CircularProgressIndicator(),),
                            fallback: (context)=>defaultButton(
                                onPressed: (){
                                  if(formKey.currentState!.validate()){
                                        cubit.userLogin(
                                            email: emailController.text,
                                            password: passwordController.text
                                        );
                                  }
                                },
                                text: 'Login',
                                borderRadius: 5,
                              gradientColors: [Colors.green,Colors.lightGreen]
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have and account? ',
                                style: TextStyle(
                                ),
                              ),
                              defaultTextButton(
                                  function: (){
                                    navigateTo(context: context, screen: RegisterScreen());
                                  },
                                   text: 'Register'
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          listener: (context,state){
              if(state is LoginUserSuccessState){
                if(state.loginModel.status!){
                  showToast(msg: state.loginModel.message!, state: ToastState.SUCCESS);
                  CacheHelper.saveData(key: USERNAME, value: state.loginModel.data?.name);
                  CacheHelper.saveData(key: TOKEN, value: state.loginModel.data?.token)
                  .then((value){
                      navigateAndFinish(context: context, screen:  ShopLayout());
                  });
                }else{
                    showToast(msg: state.loginModel.message!, state: ToastState.WARNING);
                }
              }else if(state is LoginUserErrorState){
                showToast(msg: state.error, state: ToastState.ERROR);
              }
          }
      ),
    );
  }
}
