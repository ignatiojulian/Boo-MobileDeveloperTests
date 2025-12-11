import 'package:equatable/equatable.dart';
import '../models/profile.dart';

class MatchingState extends Equatable {
  final List<Profile> profiles;
  final int index;
  final String? lastAction;
  const MatchingState({
    required this.profiles,
    required this.index,
    this.lastAction,
  });
  bool get hasMore => index < profiles.length;
  Profile? get current => hasMore ? profiles[index] : null;
  MatchingState copyWith({
    List<Profile>? profiles,
    int? index,
    String? lastAction,
  }) {
    return MatchingState(
      profiles: profiles ?? this.profiles,
      index: index ?? this.index,
      lastAction: lastAction,
    );
  }
  @override
  List<Object?> get props => [profiles, index, lastAction];
}

