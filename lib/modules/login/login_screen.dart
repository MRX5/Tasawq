import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginStates>(
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
                        Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.green),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: TextStyle(
                              fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        defaultTextFormFiled(
                            controller: emailController,
                            prefixIcon: Icons.email,
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
                         SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormFiled(
                            controller: passwordController,
                            prefixIcon: Icons.lock,
                            suffixIcon: cubit.suffixIcon,
                            onSuffixIconTap: (){
                                cubit.changePasswordVisibility();
                            },
                            label: 'Password',
                            onSubmit: (String value){
                              if(formKey.currentState!.validate()){
                                return '';
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
                        SizedBox(
                          height: 40.0,
                        ),
                        defaultButton(
                            onPressed: (){
                              if(formKey.currentState!.validate()){

                              }
                            },
                            text: 'Login',
                            borderRadius: 5,
                          gradientColors: [Colors.green,Colors.lightGreen]
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have and account? ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                                onPressed: (){
                                  navigateTo(context: context, screen: RegisterScreen());
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold
                                  ),
                                ))
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

        }
    );
  }
}
