
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/state.dart';
import 'package:shop_app/shared/compoments/compoments.dart';

class SearchScreen extends StatelessWidget {
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) return 'Cannot be Empty';
                    },
                    onFieldSubmitted: (String txt){
                      SearchCubit.get(context).search(text: txt);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 0.8),
                      ),
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if(state is LoadingSearchState)
                  LinearProgressIndicator(),
                  if(state is SuccessSearchState)
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index)=>
                          BuildProItems(SearchCubit.get(context).searchModel!.data!.data[index],context,isoldprice: false),
                      separatorBuilder: (context,index)=>
                          MyDivider(),
                      itemCount:
                      SearchCubit.get(context).searchModel!.data!.data.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}