import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/cubit/shop_layout_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/local/cache_helper.dart';

import '../shared/components/constants.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context, state) {

      },
      builder:(context,state){
        var cubit=ShopLayoutCubit.get(context);
        return Scaffold(
          appBar:buildHomeAppBar(context,cubit.bottomNavIndex),
          body: cubit.bottomNavScreens[cubit.bottomNavIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
                cubit.changeBottomNavIndex(index);
            },
            currentIndex: cubit.bottomNavIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: HOME,
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_outlined),
                  label: CART
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outline),
                  label: FAVOURITES,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: SETTINGS,
              ),
            ],
          ),
        );
      } ,
    );
  }

   PreferredSizeWidget buildHomeAppBar(context,int index){
    return AppBar(
      leading: index==0?Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image:  DecorationImage(
              image: AssetImage(userAvatarImage),
            ),
          ),
        ),
      ):null,
      centerTitle: index==0?false:true,
      title:_getAppBarTitle(index, context)

    );
  }
  
  Widget _getAppBarTitle(int index,BuildContext context){
    if(index==0){
      return Text(
      'Hi, $username',
      style:Theme.of(context).textTheme.bodyText2,
    );}
    String title='';
    if(index==1)title='Cart';
    else if(index==2)title='Favourites';
    else title='';

    return Text(
      title,
      style: TextStyle(fontSize: 24),
    );
  }
}
