import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/profile/cubit/profile_cubit.dart';
import 'package:shop_app/modules/profile/cubit/profile_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is UserLogoutSuccessState) {
          CacheHelper.removeData(key: TOKEN);
          CacheHelper.removeData(key: USERNAME);
          showToast(msg: state.message, state: ToastState.SUCCESS);
          navigateAndFinish(context: context, screen: LoginScreen());
        } else if (state is UserLogoutErrorState) {
          showToast(msg: state.error, state: ToastState.ERROR);
        } else if (state is GetProfileErrorState) {
          showToast(msg: state.error, state: ToastState.ERROR);
        }
      },
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.loginModel != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      profileCircularImage(
                          imageUrl: userAvatarImage),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${cubit.loginModel?.data?.name}',
                        style: TextStyle(
                            color: profilePrimaryColor, fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildInfoRow(
                      icon: Icons.phone_outlined,
                      text: '${cubit.loginModel?.data?.phone}'),
                  const SizedBox(
                    height: 10,
                  ),
                  buildInfoRow(
                      icon: Icons.email_outlined,
                      text: '${cubit.loginModel?.data?.email}'),
                  const SizedBox(
                    height: 30,
                  ),
                  buildDivider(),
                  const SizedBox(
                    height: 20,
                  ),
                  buildButton(
                      function: null,
                      icon: Icons.wysiwyg_rounded,
                      text: 'My Orders'),
                  const SizedBox(
                    height: 5,
                  ),
                  buildButton(
                      function: null,
                      icon: Icons.location_on_outlined,
                      text: 'Addresses'),
                  const SizedBox(
                    height: 5,
                  ),
                  buildButton(
                      function: () {
                        navigateTo(
                            context: context, screen: EditProfileScreen());
                      },
                      icon: Icons.edit,
                      text: 'Edit Profile'),
                  const SizedBox(
                    height: 5,
                  ),
                  buildButton(
                      function: null,
                      icon: Icons.question_answer_outlined,
                      text: 'FAQs'),
                  const SizedBox(
                    height: 5,
                  ),
                  buildButton(
                      function: null,
                      icon: Icons.account_balance_rounded,
                      text: 'About us'),
                  const SizedBox(
                    height: 20,
                  ),
                  buildDivider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(Icons.power_settings_new_rounded,
                          color: HexColor('CF2142')),
                      const SizedBox(
                        width: 12,
                      ),
                      TextButton(
                          onPressed: () {
                            cubit.logout();
                          },
                          style: TextButton.styleFrom(
                              alignment: AlignmentDirectional.centerStart,
                              maximumSize: const Size(250, 50),
                              fixedSize: const Size(250, 50),
                              primary: Colors.grey),
                          child: Text(
                            'Log out',
                            style: TextStyle(
                                fontSize: 17, color: HexColor('CF2142')),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildInfoRow({
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: profileSecondaryColor,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: TextStyle(
            color: profileSecondaryColor,
          ),
        )
      ],
    );
  }

  Widget buildButton(
      {required IconData icon,
      required String text,
      required Function()? function}) {
    return Row(
      children: [
        Icon(icon, color: HexColor('567DDD')),
        SizedBox(
          width: 12,
        ),
        TextButton(
            onPressed: function,
            style: TextButton.styleFrom(
                alignment: AlignmentDirectional.centerStart,
                maximumSize: Size(250, 50),
                fixedSize: Size(double.infinity, 50),
                primary: Colors.grey),
            child: Text(
              text,
              style: TextStyle(fontSize: 17, color: profilePrimaryColor),
            )),
      ],
    );
  }

  Widget buildDivider() {
    return Container(
      color: profileSecondaryColor,
      width: double.infinity,
      height: 1,
    );
  }
}
