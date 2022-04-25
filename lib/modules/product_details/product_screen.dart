import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/cubit/shop_layout_cubit.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/utils/utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../layout/cubit/shop_layout_states.dart';

class ProductScreen extends StatelessWidget {
   ProductScreen(
      {required this.productId, Key? key}) : super(key: key);

  final int? productId;

  @override
  Widget build(BuildContext context) {
    ShopLayoutCubit.get(context).getProductDetails(productId: productId!);
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {
        if (state is GetProductSuccessStateState) {
          if (!state.model.status) {
            showToast(msg: '${state.model.message}', state: ToastState.ERROR);
          }
        } else if (state is GetProductErrorState) {
          showToast(msg: state.error, state: ToastState.ERROR);
        }
      },
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
             icon:const Icon(Icons.arrow_back_ios,),
              onPressed: (){
                  Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    cubit.changeCart(productId);
                  },
                  icon: roundedIconContainer(
                      padding: 5,
                      child: cubit.inCart[productId]??false
                          ? const Icon(
                              Icons.add_shopping_cart_rounded,
                              color: Colors.lightGreen,
                              size: 23,
                            )
                          : Icon(
                              Icons.add_shopping_cart_rounded,
                              color: HexColor('C5C9D3'),
                              size: 23,
                            ))),
              IconButton(
                  onPressed: () {
                    cubit.changeFavourites(productId);
                  },
                  icon: roundedIconContainer(
                      child: cubit.favourites[productId]??false
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.lightGreen,
                            )
                          : Icon(
                              Icons.favorite_outline,
                              color: HexColor('C5C9D3'),
                            ))),
            ],
            title: const Text(
              'Details',
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: ConditionalBuilder(
            condition: cubit.productDetailsModel!=null,
            builder:(context)=> SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  buildProductImagesContainer(context),
                  SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: HexColor('C5C9D3').withOpacity(.5),
                            blurRadius: 10)
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildProductNameAndPriceRow(context),
                        SizedBox(
                          height: 20,
                        ),
                        buildRatingBarRow(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Description',
                        ),
                        Text(
                          '${cubit.productDetailsModel?.data?.description}',
                          style:
                              TextStyle(color: HexColor('C5C9D3'), fontSize: 13),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            fallback: (context)=>const Center(child: CircularProgressIndicator(),),
          ),
        );
      },
    );
  }
  
  Widget buildProductImagesContainer(context)=> Container(
      width: double.infinity,
      child: CarouselSlider(
        items: ShopLayoutCubit.get(context).productDetailsModel?.data?.images.map((e)=>
           Image(
            fit: BoxFit.cover,
            image: NetworkImage(e),
            height: 300,
          )
        ).toList(),
        options:CarouselOptions(
          autoPlayInterval: Duration(seconds: 4),
          autoPlayAnimationDuration: Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          reverse: false,
          viewportFraction: 1.0,
          enlargeCenterPage: true,
          autoPlay: true,
          initialPage: 0,
          height: 300,
        ),
      ),
    );
  
  Widget buildProductNameAndPriceRow(context) {
    var model=ShopLayoutCubit.get(context).productDetailsModel?.data;
    return Row(
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        Expanded(
          child: Text(
            '${model?.name}',
            style: TextStyle(
              height: 1.1,
              fontSize: 18,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          width: 50,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  Utils.formatPrice(model?.price),
                  style: TextStyle(
                      color: Colors.green, fontSize: 15, height: 1),
                ),
              ],
            ),
            if(model?.discount!=0)
              Text(
              Utils.formatPrice(model?.oldPrice),
              style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }
  
  Widget buildRatingBarRow()=>Row(
    children: [
      RatingBar.builder(
        itemCount: 5,
        minRating: 1,
        maxRating: 5,
        itemSize: 15,
        initialRating: 4.9,
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {},
      ),
      SizedBox(
        width: 4,
      ),
      Text(
        '(4.8)',
        style: TextStyle(fontSize: 14),
      )
    ],
  );
}
