import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sallate/models/search_model.dart';
import 'package:Sallate/modules/search/cubit/states.dart';
import 'package:Sallate/shared/components/constants.dart';
import 'package:Sallate/shared/network/end_point.dart';
import 'package:Sallate/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;

  void search({required String text}) {
    emit(SearchLodingState());
    DioHelper.postData(
      url: Search,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) async {
      searchModel = await SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
