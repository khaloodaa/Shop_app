import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/compoments/compoments.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopChangeSuccessFavoritesState){
          if(!state.model.status!){
            ShowToast(
              state: ToastStates.ERROR ,
              text: state.model.message!,
            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: cubit.homeModel !=null && cubit.categoriesModel !=null,
          builder: (context) => HomeBuilder(cubit.homeModel!,cubit.categoriesModel!,context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget HomeBuilder(HomeModel model,CategoriesModel categoriesModel,context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map(
                    (e) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 100,
                initialPage: 0,
                viewportFraction: 0.85,
                autoPlay: true,
                enableInfiniteScroll: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                reverse: false,
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 19,fontWeight: FontWeight.w800,color: DefaultColor),),
                  Container(
                    height: 80,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index)=>CategoriesBuilder(categoriesModel.data.data[index]),
                        separatorBuilder: (context,index)=> SizedBox(
                            width: 5
                        ),
                        itemCount: categoriesModel.data.data.length,
                    ),
                  ),
                  SizedBox(
                    height: 10,),
                  Text(
                    'New Products',
                    style: TextStyle(fontSize: 19,fontWeight: FontWeight.w800,color: DefaultColor),),
                ],
              ),
            ),
            Container(
              color: Colors.grey[200],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1 / 1.42,
                crossAxisCount: 2,
                children: List.generate(
                  model.data.products.length,
                  (index) => ProductsBuilder(model.data.products[index],context),
                ),
              ),
            ),
          ],
        ),
      );

  Widget CategoriesBuilder(DataModel model)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(model.image!),
              fit: BoxFit.cover,
            )),
      ),
      Container(
        color: Colors.white.withOpacity(0.5),
        width: 70,
        child: Text(
          model.name!,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black),),
      ),
    ],
  );

  Widget ProductsBuilder(ProductsModel model,context) => Container(
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  height: 190,
                  width: double.infinity,
                ),
                if(model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, height: 1.2),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}' + ' \$',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: DefaultColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 5,),
                      if(model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}' + ' \$',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Spacer(),
                      CircleAvatar(
                        backgroundColor: ShopCubit.get(context).favorites[model.id]! ? DefaultColor : Colors.grey[400],
                        maxRadius: 17,
                        child: IconButton(
                         onPressed: (){
                           ShopCubit.get(context).SaveFavorites(model.id);
                           },
                         icon: Icon(Icons.favorite_border),
                         color: Colors.white,
                         iconSize: 17,
                     ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
