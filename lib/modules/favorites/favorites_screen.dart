import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/getfavorites_model.dart';
import 'package:shop_app/shared/compoments/compoments.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit=ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return cubit.getFavoritesModel !=null ? ConditionalBuilder(
          condition: state is! ShopLoadingFavoritesState,
          builder: (context)=>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>BuildProItems(cubit.getFavoritesModel!.data!.data[index].product,context),
            separatorBuilder: (context,index)=>MyDivider(),
            itemCount: cubit.getFavoritesModel!.data!.data.length,
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        ):
        Center(child: CircularProgressIndicator());
      },
    );
  }


}