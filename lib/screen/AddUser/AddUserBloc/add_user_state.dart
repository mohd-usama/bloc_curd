import 'package:bloc_curd/Model/add_qualification_model.dart';
import 'package:equatable/equatable.dart';

class AddUserState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? isError;
  final List<AddQualificationModel>? addQualificationDetails;

  const AddUserState({this.isLoading = false, this.isSuccess = false, this.isError, this.addQualificationDetails});

  AddUserState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    List<AddQualificationModel>? addQualificationDetails,
  }) {
    return AddUserState(
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        isError: error,
        addQualificationDetails: addQualificationDetails ?? this.addQualificationDetails);
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isError, addQualificationDetails];
}
