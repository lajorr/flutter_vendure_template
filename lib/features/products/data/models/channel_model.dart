import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/channel.dart';

part 'channel_model.freezed.dart';
part 'channel_model.g.dart';

@freezed
abstract class ChannelModel with _$ChannelModel {
  const factory ChannelModel({required String id, required String code}) =
      _ChannelModel;

  factory ChannelModel.fromJson(Map<String, dynamic> json) =>
      _$ChannelModelFromJson(json);

  const ChannelModel._();

  Channel toEntity() => Channel(id: id, code: code);
}
