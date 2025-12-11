import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/profile.dart';
import 'matching_state.dart';

class MatchingCubit extends Cubit<MatchingState> {
  MatchingCubit()
      : super(const MatchingState(
          profiles: [
            Profile(
              name: 'Alex',
              age: 25,
              role: 'Designer',
              location: 'San Francisco, USA',
              verified: true,
              mbti: 'ENFP',
              sign: 'Aries',
              bio: 'Designer, coffee addict, weekend hiker.',
              images: [
                'https://picsum.photos/seed/alex/1024/1400',
                'https://picsum.photos/seed/alex2/1024/1400',
              ],
              interests: ['Art', 'Coffee', 'Travel'],
            ),
            Profile(
              name: 'Sam',
              age: 28,
              role: 'Software Engineer',
              location: 'Seattle, USA',
              verified: false,
              mbti: 'INTJ',
              sign: 'Leo',
              bio: 'Engineer who loves indie games and ramen.',
              images: [
                'https://picsum.photos/seed/sam/1024/1400',
                'https://picsum.photos/seed/sam2/1024/1400',
              ],
              interests: ['Gaming', 'Ramen', 'Running'],
            ),
            Profile(
              name: 'Jamie',
              age: 24,
              role: 'Photographer',
              location: 'Austin, USA',
              verified: true,
              mbti: 'ESTP',
              sign: 'Gemini',
              bio: 'Photographer, cat parent, sunset chaser.',
              images: [
                'https://picsum.photos/seed/jamie/1024/1400',
                'https://picsum.photos/seed/jamie2/1024/1400',
              ],
              interests: ['Photography', 'Cats', 'Yoga'],
            ),
          ],
          index: 0,
        ));

  void like() {
    emit(state.copyWith(lastAction: 'like'));
    next();
  }

  void pass() {
    emit(state.copyWith(lastAction: 'pass'));
    next();
  }

  void next() {
    if (!state.hasMore) return;
    final nextIndex = state.index + 1;
    emit(state.copyWith(index: nextIndex, lastAction: null));
  }
}
