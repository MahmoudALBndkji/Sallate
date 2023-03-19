import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sallate/modules/search/cubit/cubit.dart';
import 'package:Sallate/modules/search/cubit/states.dart';
import 'package:Sallate/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0.1,
              actions: [
                Icon(
                  Icons.content_paste_search_outlined,
                  size: 24.0,
                ),
                SizedBox(
                  width: 20.0,
                ),
              ],
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      action: TextInputAction.search,
                      validation: (value) {
                        if (value.isEmpty) return 'Search For Any Thing';
                      },
                      onSubmit: (String text) {
                        cubit.search(text: text);
                      },
                      labelText: "Search",
                      prefixIcon: Icons.manage_search_outlined,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLodingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    if (state is! SearchSuccessState)
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.blue, width: 1),
                            ),
                            child: Icon(
                              Icons.search,
                              size: 60.0,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Search For What You Want',
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.blue,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildListProduct(
                            cubit.searchModel!.data!.data![index],
                            context,
                            isOldPrice: false,
                          ),
                          separatorBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: Divider(
                              height: 2,
                              color: Colors.grey,
                              thickness: 1.5,
                            ),
                          ),
                          itemCount: cubit.searchModel!.data!.data!.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
