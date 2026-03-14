import 'package:equatable/equatable.dart';

class StockLevel extends Equatable {
  final int stockOnHand;
  final int stockAllocated;

  const StockLevel({
    required this.stockOnHand,
    required this.stockAllocated,
  });

  @override
  List<Object?> get props => [stockOnHand, stockAllocated];
}
