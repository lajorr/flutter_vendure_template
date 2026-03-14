import 'package:equatable/equatable.dart';

class Asset extends Equatable {
  final String id;
  final String preview;
  final String source;
  final String? name;

  const Asset({
    required this.id,
    required this.preview,
    required this.source,
    this.name,
  });

  @override
  List<Object?> get props => [id, preview, source, name];
}
