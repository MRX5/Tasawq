import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/modules/home/cubit/home_cubit.dart';
import 'package:shop_app/modules/home/cubit/home_states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../models/home_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoryModel != null,
            builder: (context) => buildHomeWidget(cubit.homeModel, cubit),
            fallback: (context) =>
            const Center(child: CircularProgressIndicator())
        );
      },
    );
  }

  Widget buildHomeWidget(HomeModel? homeModel, HomeCubit cubit) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onTap: () {},
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: CarouselSlider(
                    items: homeModel?.data?.banners.map((e) =>
                        Image(image: NetworkImage(e.image ?? ''),
                          fit: BoxFit.cover,
                          width: double.infinity,)
                    ).toList(),
                    options: CarouselOptions(
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(seconds: 1),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      reverse: false,
                      viewportFraction: 1.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      initialPage: 0,
                      height: 180,
                    )),
              ),
              SizedBox(height: 20,),

              Text(
                'Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
              Container(
                height: 120,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildCategoryWidget(
                      cubit.categoryModel?.data?.categoriesList[index]),
                  separatorBuilder: (context, index) => SizedBox(width: 20,),
                  itemCount: cubit.categoryModel?.data?.categoriesList.length ??
                      0,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                'Recommended',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                childAspectRatio: 1 / 2,
                children: List.generate(
                    homeModel?.data?.products.length ?? 0, (index) =>
                    buildProductWidget(homeModel?.data?.products[index],cubit)),
              )
            ],
          ),
        )
    );
  }


  Widget buildProductWidget(ProductModel? product,HomeCubit cubit) {
    return GestureDetector(
      onTap: (){},
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(product?.image ?? ''),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.contain,),
                  if(product?.discount != 0)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.red,
                      child: Text(
                        'Discount ${product?.discount}%',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    )
                ]
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        product?.name ?? '',
                        style: TextStyle(fontSize: 14.0,height: 1.3),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text(
                          '${product?.price.round()}',
                          style: TextStyle(fontSize: 14, color: green),
                          maxLines: 1,
                        ),
                        SizedBox(width: 2,),
                        Text(
                          'EGP',
                          style: TextStyle(color: Colors.green, fontSize: 10),
                        ),
                        Spacer(),
                        IconButton(
                          alignment: AlignmentDirectional.centerEnd,
                          onPressed: () {
                            cubit.changeFavourites(product?.id);
                          },
                          icon: cubit.favourites[product?.id]?? false ?
                               Icon(Icons.favorite,color: lightGreen):Icon(Icons.favorite_outline,),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCategoryWidget(CategoryInfo? categoryModel) {
    return GestureDetector(
      onTap: (){},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: Colors.green.withOpacity(.2),
            ),

            child: Image(
              color: green,
              image: AssetImage(getCategoryImage(categoryModel?.id) ?? ''),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5,),
          Container(
            width: 70,
            child: Text(
              '${categoryModel?.name}',
              style: TextStyle(fontSize: 12,),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          )
        ]),
    );
  }
}
