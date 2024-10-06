// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pdf_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PdfData _$PdfFileFromJson(Map<String, dynamic> json) {
  return _PdfFile.fromJson(json);
}

/// @nodoc
mixin _$PdfFile {
  String get name => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get file => throw _privateConstructorUsedError;

  /// Serializes this PdfFile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PdfFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PdfFileCopyWith<PdfData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PdfFileCopyWith<$Res> {
  factory $PdfFileCopyWith(PdfData value, $Res Function(PdfData) then) =
      _$PdfFileCopyWithImpl<$Res, PdfData>;
  @useResult
  $Res call({String name, String date, String file});
}

/// @nodoc
class _$PdfFileCopyWithImpl<$Res, $Val extends PdfData>
    implements $PdfFileCopyWith<$Res> {
  _$PdfFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PdfFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? date = null,
    Object? file = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PdfFileImplCopyWith<$Res> implements $PdfFileCopyWith<$Res> {
  factory _$$PdfFileImplCopyWith(
          _$PdfFileImpl value, $Res Function(_$PdfFileImpl) then) =
      __$$PdfFileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String date, String file});
}

/// @nodoc
class __$$PdfFileImplCopyWithImpl<$Res>
    extends _$PdfFileCopyWithImpl<$Res, _$PdfFileImpl>
    implements _$$PdfFileImplCopyWith<$Res> {
  __$$PdfFileImplCopyWithImpl(
      _$PdfFileImpl _value, $Res Function(_$PdfFileImpl) _then)
      : super(_value, _then);

  /// Create a copy of PdfFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? date = null,
    Object? file = null,
  }) {
    return _then(_$PdfFileImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PdfFileImpl implements _PdfFile {
  const _$PdfFileImpl(
      {required this.name, required this.date, required this.file});

  factory _$PdfFileImpl.fromJson(Map<String, dynamic> json) =>
      _$$PdfFileImplFromJson(json);

  @override
  final String name;
  @override
  final String date;
  @override
  final String file;

  @override
  String toString() {
    return 'PdfFile(name: $name, date: $date, file: $file)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PdfFileImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.file, file) || other.file == file));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, date, file);

  /// Create a copy of PdfFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PdfFileImplCopyWith<_$PdfFileImpl> get copyWith =>
      __$$PdfFileImplCopyWithImpl<_$PdfFileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PdfFileImplToJson(
      this,
    );
  }
}

abstract class _PdfFile implements PdfData {
  const factory _PdfFile(
      {required final String name,
      required final String date,
      required final String file}) = _$PdfFileImpl;

  factory _PdfFile.fromJson(Map<String, dynamic> json) = _$PdfFileImpl.fromJson;

  @override
  String get name;
  @override
  String get date;
  @override
  String get file;

  /// Create a copy of PdfFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PdfFileImplCopyWith<_$PdfFileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
