import 'package:bloc/bloc.dart';
import 'package:bloc_curd/Model/user_model.dart';
import 'package:bloc_curd/screen/ShowUser/ShowUserBloc/show_user_event.dart';
import 'package:bloc_curd/screen/ShowUser/ShowUserBloc/show_user_state.dart';
import 'package:bloc_curd/sqfliteHelper/database_handler.dart';

class ShowUserBloc extends Bloc<ShowUserEvent, ShowUserState> {
  ShowUserBloc() : super(ShowUserState()) {

    on<FetchUserList>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null));
      List<UserModel> getUserModelList = [];
      List<Map<String, dynamic>> dummyList = await DatabaseHelper.query();
      getUserModelList.clear();
      for (var data in dummyList) {
        getUserModelList.add(UserModel.fromJson(data));
      }

      emit(state.copyWith(showUserList: getUserModelList, isLoading: false));
    });
  }
}
