import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/cubit/shop_layout_states.dart';
import 'package:shop_app/models/favourites/favouritesModel.dart';
import 'package:shop_app/utils/utils.dart';
import '../../shared/styles/colors.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
        builder: (context, state) {
          var cubit = ShopLayoutCubit.get(context);
          return ConditionalBuilder(
              condition: state is! GetFavouritesLoadingState,
              builder: (context)=>ListView.separated(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildListItem(model: cubit.favouritesModel?.data?.data[index].product, context: context),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: cubit.favouritesModel?.data?.data.length ?? 0),
              fallback: (context)=>const Center(child: CircularProgressIndicator(),),
          );
        },
        listener: (context, state) {

        });
  }

  Widget buildListItem({required Product? model, required context}) {
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
          height: 180,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${model?.image}'),
                    width: 120,
                    height: 180,
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
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model?.name ?? '',
                        style: TextStyle(fontSize: 15.0, height: 1.3),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            Utils.formatPrice(model?.price.round(),withSymbol: false),
                            style: TextStyle(fontSize: 16, color: green),
                            maxLines: 1,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'EGP',
                            style: TextStyle(color: Colors.green, fontSize: 10),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          if (model?.discount != 0)
                            Text(
                              '${model?.oldPrice.round()}',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          Spacer(),
                          IconButton(
                            alignment: AlignmentDirectional.centerEnd,
                            onPressed: () {
                              cubit.changeFavourites(model?.id);
                            },
                            icon: cubit.favourites[model?.id] ?? false
                                ? Icon(Icons.favorite, color: lightGreen)
                                : Icon(
                                    Icons.favorite_outline,
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
