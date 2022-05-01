import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prmt_admin/blocs/nav/nav_state.dart';
import '/enums/enums.dart';
part 'nav_event.dart';

// class NavBloc extends Bloc<NavEvent, NavItem> {
//   NavBloc() : super(NavItem.dashboard) {
//     on<NavEvent>((event, emit) {
//       if (event is UpdateNavItem) {
//         emit(event.item);
//       }
//     });
//   }
// }

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(NavState.initial()) {
    on<NavEvent>((event, emit) {
      if (event is UpdateNavItem) {
        emit(state.copyWith(item: event.item));
      }
    });
  }
}
