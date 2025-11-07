import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/fetch_user_profile.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FetchUserProfile fetchUserProfileUseCase;

  ProfileBloc({required this.fetchUserProfileUseCase}) : super(const ProfileState()) {
    on<FetchProfile>(_onFetchProfile);
    on<SelectedTab>(_onSelectTab);
  }

  Future<void> _onFetchProfile(FetchProfile event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final profile = await fetchUserProfileUseCase(uid: event.uid);
      emit(state.copyWith(isLoading: false, profile: profile));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void _onSelectTab(SelectedTab event, Emitter<ProfileState> emit) {
    emit(state.copyWith(selectedTab: event.tab));
  }
}
