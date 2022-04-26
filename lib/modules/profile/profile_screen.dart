import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  child: Image(
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://www.pngitem.com/pimgs/m/22-220721_circled-user-male-type-user-colorful-icon-png.png'),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Mostafa Gad',
                  style: TextStyle(color: profilePrimaryColor, fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            buildInfoRow(icon: Icons.phone_outlined, text: '106-958-0451'),
            SizedBox(
              height: 10,
            ),
            buildInfoRow(
                icon: Icons.email_outlined, text: 'm.gad192@gmail.com'),
            SizedBox(
              height: 30,
            ),
            buildDivider(),
            SizedBox(
              height: 20,
            ),
            buildButton(icon: Icons.wysiwyg_rounded, text: 'My Orders'),
            SizedBox(
              height: 10,
            ),
            buildButton(icon: Icons.location_on_outlined, text: 'Addresses'),
            SizedBox(
              height: 10,
            ),
            buildButton(icon: Icons.edit, text: 'Edit Profile'),
            SizedBox(
              height: 10,
            ),
            buildButton(icon: Icons.question_answer_outlined, text: 'FAQs'),
            SizedBox(
              height: 10,
            ),
            buildButton(icon: Icons.account_balance_rounded, text: 'About us'),
            SizedBox(
              height: 20,
            ),
            buildDivider(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(Icons.power_settings_new_rounded,
                    color: HexColor('CF2142')),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        alignment: AlignmentDirectional.centerStart,
                        maximumSize: Size(320, 50),
                        fixedSize: Size(320, 50),
                        primary: Colors.grey
                    ),
                    child: Text(
                      'Log out',
                      style: TextStyle(fontSize: 17, color: HexColor('CF2142')),
                    )),
              ],
            ),
          ],
        ),
      ),
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

  Widget buildButton({
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Icon(icon, color: HexColor('567DDD')),
        SizedBox(
          width: 12,
        ),
        TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              alignment: AlignmentDirectional.centerStart,
              maximumSize: Size(320, 50),
              fixedSize: Size(double.infinity, 50),
              primary: Colors.grey
            ),
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
