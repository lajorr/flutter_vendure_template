import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_controller.g.dart';

@riverpod
class DashboardController extends _$DashboardController {
  @override
  int build() {
    return 0; // Default index (Home)
  }

  void setIndex(int index) {
    state = index;
  }
}
