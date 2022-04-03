import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prmt_business/models/appuser.dart';
import 'package:prmt_business/models/failure.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initial()) {
    on<ProfileEvent>((event, emit) {});
  }
}
