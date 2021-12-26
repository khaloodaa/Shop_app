import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/compoments/compoments.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('SALLA'),
            actions: [
              IconButton(
                onPressed: () {
                  NavigatTo(context, SearchScreen());
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.Screens[cubit.Currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.Currentindex,
            onTap: (index) {
              cubit.ChangeBottomNav(index);
            },
            items: cubit.NavItems,
          ),
        );
      },
    );
  }
}
