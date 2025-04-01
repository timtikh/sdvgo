// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map<String, dynamic> json) => Video(
      id: json['id'] as String,
      user: json['user'] as String,
      userPic: json['userPic'] as String,
      videoTitle: json['videoTitle'] as String,
      likes: json['likes'] as String,
      uri: Uri.parse(json['uri'] as String),
    );

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'userPic': instance.userPic,
      'videoTitle': instance.videoTitle,
      'likes': instance.likes,
      'uri': instance.uri.toString(),
    };
