import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/compoments/compoments.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) =>
              CategoriesBottomBuilder(cubit.categoriesModel!.data.data[index]),
          separatorBuilder: (context, index) => MyDivider(),
          itemCount: cubit.categoriesModel!.data.data.length,
        );
      },
    );
  }

  Widget CategoriesBottomBuilder(DataModel model) => Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                image: NetworkImage(model.image!),
                    fit: BoxFit.cover,
              )),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                model.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      );
}
