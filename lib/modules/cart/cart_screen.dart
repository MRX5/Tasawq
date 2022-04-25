import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/utils/utils.dart';

import '../../layout/cubit/shop_layout_cubit.dart';
import '../../layout/cubit/shop_layout_states.dart';
import '../../models/cart/cart_model.dart';
import '../../shared/styles/colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit=ShopLayoutCubit.get(context);
    if(cubit.cartModel?.data?.cartItems==null){
      cubit.getInCartProducts();
    }
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
        builder: (context, state) {
          var cubit = ShopLayoutCubit.get(context);
          return ConditionalBuilder(
            condition: state is! GetCartLoadingState,
            builder: (context)=>ListView.separated(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildListItem(model:cubit.cartModel?.data?.cartItems[index].product,index: index, context: context),
                separatorBuilder: (context, index) => const SizedBox(height: 10,),
                itemCount: cubit.cartModel?.data?.cartItems?.length ?? 0),
            fallback: (context)=>const Center(child: CircularProgressIndicator(),),
          );
        },
        listener: (context, state) {
          if(state is GetCartSuccessState){
            if(!state.cartModel.status){
              showToast(msg: '${state.cartModel.message}', state: ToastState.ERROR);
            }
          }
          else if(state is GetCartErrorState){
            showToast(msg: state.error, state: ToastState.ERROR);
          }
        });
  }

  Widget buildListItem({required Product? model,required int index, required context}) {
    var cubit = ShopLayoutCubit.get(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          color: Colors.white,
          height: 150,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${model?.image}'),
                    width: 120,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                  if (model?.discount != 0)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                      color: Colors.red,
                      child: Text(
                        'Discount ${model?.discount}%',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(top: 20,start: 10,end: 10,bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model?.name ?? '',
                        style: TextStyle(fontSize: 15.0, height: 1.3),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    Utils.formatPrice(cubit.cartModel?.data?.cartItems[index].product?.price,withSymbol: false),
                                    style: TextStyle(fontSize: 15, color: green),
                                    maxLines: 1,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    'EGP',
                                    style: TextStyle(color: Colors.green, fontSize: 10),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [BoxShadow(color: HexColor('C5C9D3'),blurRadius: 1)]
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: (){
                                          cubit.decreaseProductQuantity(productId: index);
                                        },
                                        icon: Icon(Icons.remove),
                                      constraints: BoxConstraints(),
                                      padding: EdgeInsets.all(4),
                                    ),
                                    SizedBox(width: 10,),
                                    Text(
                                      '${cubit.cartModel?.data?.cartItems[index].quantity}',
                                    ),
                                    SizedBox(width: 10,),
                                    IconButton(
                                        onPressed: (){
                                          cubit.increaseProductQuantity(productId: index);
                                        },
                                        icon: Icon(Icons.add),
                                      constraints: BoxConstraints(),
                                      padding: EdgeInsets.zero,

                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            alignment: AlignmentDirectional.bottomEnd,
                            decoration: BoxDecoration(
                              color: HexColor('FDE9E8'),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              color: Colors.redAccent,
                              onPressed: () {
                                cubit.changeCart(model?.id);
                              },
                              icon: Icon(Icons.delete_forever,color: Colors.redAccent,),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
