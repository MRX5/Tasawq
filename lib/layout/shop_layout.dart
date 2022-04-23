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
          appBar:cubit.bottomNavIndex==0? buildHomeAppBar(context):AppBar(
            title: Text('Tasawq'),
          ),
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
                  icon: Icon(Icons.apps),
                  label: CATEGORIES
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

   PreferredSizeWidget buildHomeAppBar(context){
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
              image: NetworkImage('https://www.pngitem.com/pimgs/m/22-220721_circled-user-male-type-user-colorful-icon-png.png'),
            ),
          ),
        ),
      ),
      title: Text(
        'Hi, Mostafa',
        style:Theme.of(context).textTheme.bodyText2,),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined, ))
      ],
    );
  }
}
