// presentation/bloc/profile_event.dart

import 'package:equatable/equatable.dart';

enum ProfileTab{favorite,notification}

abstract class ProfileEvent extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
  
}

class FetchProfile extends ProfileEvent {
  final String uid;
  FetchProfile(this.uid);

  
  @override
  // TODO: implement props
  List<Object?> get props => [uid];


}


class SelectedTab extends ProfileEvent{
  final ProfileTab tab;
  SelectedTab(this.tab);
  
  @override
  // TODO: implement props
  List<Object?> get props => [tab];




}
