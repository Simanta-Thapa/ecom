// presentation/bloc/profile_event.dart

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

enum ProfileTab{favorite,notification}

sealed class ProfileEvent extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
  
}

final class FetchProfile extends ProfileEvent {
  final String uid;
  FetchProfile(this.uid);

  
  @override
  // TODO: implement props
  List<Object?> get props => [uid];


}


final class SelectedTab extends ProfileEvent{
  final ProfileTab tab;
  SelectedTab(this.tab);
  
  @override
  // TODO: implement props
  List<Object?> get props => [tab];




}


final class OnSelectImage extends ProfileEvent{
  final ImageSource source;


  OnSelectImage(this.source);


}
