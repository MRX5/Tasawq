import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/search_cubit.dart';
import 'package:shop_app/modules/search/cubit/search_states.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../shared/styles/colors.dart';
import '../../utils/utils.dart';
import '../product_details/product_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {
          if (state is SearchErrorState) {
            showToast(msg: state.error, state: ToastState.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          autofocus: true,
                          onChanged: (query) {
                            if (query.isNotEmpty) {
                              cubit.searchFor(query: query);
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search_rounded),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if(state is SearchSuccessState)
                        Row(
                          children: [
                            Text(
                              '${cubit.searchModel?.data?.items.length} Results found'
                            ),
                            Spacer(),
                            PopupMenuButton(
                                enabled: true,
                                icon: Icon(Icons.sort_rounded),
                                itemBuilder: (context)=>[
                                  const PopupMenuItem(
                                      child:Text(
                                        'A-Z',
                                      ),
                                    value: 1,
                                  ),
                                  const PopupMenuItem(
                                      child:Text(
                                        'Z-A',
                                      ),
                                    value: 2,
                                  ),
                                  const PopupMenuItem(
                                      child:Text(
                                        'Price low to high',
                                      ),
                                    value: 3,
                                  ),
                                  const PopupMenuItem(
                                      child:Text(
                                        'Price high to low',
                                      ),
                                    value: 4,
                                  ),
                                ]
                            )
                          ],
                        ),
                        if (state is SearchLoadingState)
                          const LinearProgressIndicator(),
                        const SizedBox(
                          height: 10,
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1 / 2,
                          children: List.generate(
                              cubit.searchModel?.data?.items?.length ?? 0,
                              (index) => buildProductWidget(
                                  cubit.searchModel?.data?.items![index],
                                  context)),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget buildProductWidget(SearchItem? product, context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
            context: context, screen: ProductScreen(productId: product?.id));
      },
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage(product?.image ?? ''),
              width: double.infinity,
              height: 180,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        product?.name ?? '',
                        style: const TextStyle(fontSize: 14.0, height: 1.3),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          Utils.formatPrice(product?.price?.round(),
                              withSymbol: false),
                          style: const TextStyle(fontSize: 14, color: green),
                          maxLines: 1,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        const Text(
                          'EGP',
                          style: TextStyle(color: Colors.green, fontSize: 10),
                        ),
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

}
