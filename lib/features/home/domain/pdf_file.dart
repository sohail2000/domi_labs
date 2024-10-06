import 'package:freezed_annotation/freezed_annotation.dart';

part 'pdf_file.freezed.dart';
part 'pdf_file.g.dart';

@freezed
class PdfData with _$PdfFile {
  const factory PdfData({
    required String name,
    required String date,
    required String file,
  }) = _PdfFile;

  factory PdfData.fromJson(Map<String, dynamic> json) => _$PdfFileFromJson(json);
}


