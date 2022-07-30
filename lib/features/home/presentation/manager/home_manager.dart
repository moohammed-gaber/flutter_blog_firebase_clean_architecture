import 'package:riverpod/riverpod.dart';

final homeProvider =
    StateNotifierProvider.autoDispose<HomeStateNotifier, HomeState>((ref) {
  return HomeStateNotifier();
});

class HomeState {
  final int pageIndex;

  HomeState({required this.pageIndex});
  // copy with
  HomeState copyWith({required int pageIndex}) {
    return HomeState(pageIndex: pageIndex);
  }
}

class HomeStateNotifier extends StateNotifier<HomeState> {
  HomeStateNotifier() : super(HomeState(pageIndex: 0));
  void changePageIndex(int pageIndex) {
    state = state.copyWith(pageIndex: pageIndex);
  }
}
