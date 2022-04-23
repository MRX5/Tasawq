import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/register_states.dart';

import '../../shared/components/components.dart';
import 'cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);
   var emailController = TextEditingController();
   var usernameController = TextEditingController();
   var phoneController = TextEditingController();
   var passwordController = TextEditingController();
   var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        builder: (context, state) {
          var cubit=RegisterCubit.get(context);
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
                          'SIGN UP',
                          style: TextStyle(
                              fontSize: 40.0,
                              color: Colors.green),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        const Text(
                          'Register now to browse our hot offers',
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
                            controller: usernameController,
                            prefixIcon: Icons.person_outline,
                            label: 'Username',
                            onSubmit: (String value){
                              if(formKey.currentState!.validate()){
                                return '';
                              }
                              return null;
                            },
                            validator: (String? value){
                              if(value!.isEmpty){
                                return 'Invalid username address';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormFiled(
                            controller: emailController,
                            prefixIcon: Icons.email_outlined,
                            label: 'Email',
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
                            controller: phoneController,
                            prefixIcon: Icons.phone,
                            label: 'Phone',
                            textInputType: TextInputType.phone,
                            onSubmit: (String value){
                              if(formKey.currentState!.validate()){
                                return '';
                              }
                              return null;
                            },
                            validator: (String? value){
                              if(value!.isEmpty){
                                return 'Invalid phone address';
                              }
                              return null;
                            }),
                        SizedBox(
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
                                cubit.userRegister(
                                    email: emailController.text,
                                    username: usernameController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text);
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
                            condition: state is RegisterUserLoadingState,
                            builder:(context)=>const Center(child: CircularProgressIndicator()),
                            fallback: (context)=> defaultButton(
                            onPressed: (){
                              if(formKey.currentState!.validate()){
                                  cubit.userRegister(
                                      email: emailController.text,
                                      username: usernameController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text);
                              }
                            },
                            text: 'Sign Up',
                            borderRadius: 5,
                            gradientColors: [Colors.green,Colors.lightGreen]
                        ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context,state){
            if(state is RegisterUserErrorState){
              print(state.error);
            }
        },
      ),
    );
  }
}
