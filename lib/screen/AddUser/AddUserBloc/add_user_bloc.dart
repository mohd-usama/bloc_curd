import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_curd/sqfliteHelper/database_handler.dart';

import 'add_user_event.dart';
import 'add_user_state.dart';

class AddUserBloC extends Bloc<AddUserEvent, AddUserState> {
  AddUserBloC() : super(const AddUserState()) {
    on<SubmitUser>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null, isSuccess: false));

      try {
        await DatabaseHelper.insert(event.user);

        emit(state.copyWith(isLoading: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          error: "Insert failed",
        ));
      }
    });

    on<DeleteUser>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null, isSuccess: false));
      await DatabaseHelper.delete(event.id);
    });


    on<UpdateUser>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null, isSuccess: false));
      await DatabaseHelper.update(event.id);
      emit(state.copyWith(isLoading: false, isSuccess: true));
    });
  }
}
