import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favouritesModel.dart';
import 'package:shop_app/modules/favourites/cubit/favourites_states.dart';

import '../../shared/styles/colors.dart';
import 'cubit/favourites_cubit.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouritesCubit,FavouritesStates>(
        builder: (context, state) {
          var cubit=FavouritesCubit.get(context);
          return ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (context,index)=>buildListItem(
                  model: cubit.favouritesModel?.data?.data[index].product,
                  context: context),
              separatorBuilder: (context,index)=>const SizedBox(height: 10,),
              itemCount: cubit.favouritesModel?.data?.data.length??0
          );
        },
        listener: (context,state){

    }
    );
  }

  Widget buildListItem({
    required Product? model,
    required context
  }){
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        child: Row(
          children: [
            Stack(
              children: [
                Image(
                  image:NetworkImage(''),
                  height: 120,
                ),
                if(model?.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,
                    child: Text(
                      'Discount ${model?.discount}%',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                Column(
                  children: [
                     Text(
                      model?.name ?? '',
                      style: TextStyle(fontSize: 14.0,height: 1.3),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          '${model?.price.round()}',
                          style: TextStyle(fontSize: 14, color: green),
                          maxLines: 1,
                        ),
                        SizedBox(width: 2,),
                        Text(
                          'EGP',
                          style: TextStyle(color: Colors.green, fontSize: 10),
                        ),
                        SizedBox(width:5,),
                        if(model?.discount!=0)
                          Text(
                            '${model?.oldPrice.round()}',

                            style: TextStyle(fontSize: 12,
                              color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          alignment: AlignmentDirectional.centerEnd,
                          onPressed: () {
                            //FavouritesCubit.get(context).changeFavourites(product?.id);
                          },
                          icon: cubit.favourites[product?.id]?? false ?
                          Icon(Icons.favorite,color: lightGreen):Icon(Icons.favorite_outline,),
                        )
                      ],
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
    }
}
