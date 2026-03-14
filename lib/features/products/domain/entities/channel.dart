import 'package:equatable/equatable.dart';

class Channel extends Equatable {
  final String id;
  final String code;

  const Channel({
    required this.id,
    required this.code,
  });

  @override
  List<Object?> get props => [id, code];
}
