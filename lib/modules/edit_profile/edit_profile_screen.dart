import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/profile/cubit/profile_cubit.dart';
import 'package:shop_app/modules/profile/cubit/profile_states.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    usernameController.text='${ProfileCubit.get(context).loginModel?.data?.name}';
    emailController.text='${ProfileCubit.get(context).loginModel?.data?.email}';
    phoneController.text='${ProfileCubit.get(context).loginModel?.data?.phone}';

    return BlocConsumer<ProfileCubit, ProfileStates>(
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      profileCircularImage(
                          imageUrl:
                              'https://www.pngitem.com/pimgs/m/22-220721_circled-user-male-type-user-colorful-icon-png.png'),
                      const SizedBox(
                        height: 40.0,
                      ),
                      buildTextFormField(
                          controller: usernameController,
                          prefixIcon: Icons.person,
                          label: 'Username',
                          validator: (name) {
                            if (name!.length < 8) {
                              return 'Username must be at least 8 characters';
                            }
                            return null;
                          },
                          onSubmit: (String value) {
                            if (formKey.currentState!.validate()) {
                              return '';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 30.0,
                      ),
                      buildTextFormField(
                        controller: emailController,
                        prefixIcon: Icons.email_outlined,
                        inputType: TextInputType.emailAddress,
                        label: 'Email',
                        enabled: false,
                        validator: (name) => null,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      buildTextFormField(
                          controller: phoneController,
                          prefixIcon: Icons.phone_outlined,
                          inputType: TextInputType.phone,
                          label: 'Phone',
                          validator: (phone) {
                            if (phone!.length < 8) {
                              return 'Invalid phone number';
                            }
                            return null;
                          },
                          onSubmit: (String value) {
                            if (formKey.currentState!.validate()) {
                              return '';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 40.0,
                      ),
                      ConditionalBuilder(
                          condition: state is! EditProfileLoadingState,
                          builder:(context)=> defaultButton(
                              onPressed: () {
                                if(formKey.currentState!.validate()) {
                                  cubit.updateUserProfile(
                                    username: usernameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              borderRadius: 4,
                              text: 'Save'),
                        fallback: (context)=>const CircularProgressIndicator(),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if(state is EditProfileSuccessState){
            showToast(msg: '${state.loginModel.message}', state: ToastState.SUCCESS);
            Navigator.pop(context);
          }
          else if(state is EditProfileErrorState){
            showToast(msg: state.error, state: ToastState.ERROR);
          }
        });
  }

  Widget buildTextFormField({
    required TextEditingController controller,
    required IconData prefixIcon,
    required String label,
    required String? Function(String?) validator,
    Function(String)? onSubmit,
    bool enabled = true,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onFieldSubmitted: onSubmit,
      enabled: enabled,
      keyboardType: inputType,
      style: TextStyle(color: profileSecondaryColor),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsetsDirectional.all(14),
        hintText: label,
        prefixIcon: Icon(prefixIcon),
      ),
    );
  }
}
