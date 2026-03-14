import 'package:bloc_curd/Model/user_model.dart';
import 'package:equatable/equatable.dart';

class ShowUserState extends Equatable {
  final List<UserModel> showUserList;
  final bool isLoading;
  final String error;

  ShowUserState({this.showUserList = const [], this.isLoading = false, this.error = ""});

  ShowUserState copyWith({
    List<UserModel>? showUserList,
    bool? isLoading,
    String? error,
  }) {
    return ShowUserState(
      showUserList: showUserList ?? this.showUserList,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [showUserList,isLoading,error];
}
