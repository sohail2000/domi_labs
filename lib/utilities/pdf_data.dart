import 'package:domi_labs/features/home/domain/pdf_file.dart';

final List<Map<String, String>> pdfFiles = [
  {
    "name": "100 Martinique Ave Title",
    "date": "Dec 4, 2023",
    "file": 'https://web.mit.edu/6.829/www/currentsemester/materials/lecture2.pdf'
  },
  {
    "name": "Chase Bank Statement - November 2023",
    "date": "Dec 3, 2023",
    "file": 'https://web.mit.edu/6.829/www/currentsemester/materials/lecture1.pdf'
  },
  {
    "name": "Utility Bill - October 2023",
    "date": "Nov 15, 2023",
    "file": 'https://web.mit.edu/6.829/www/currentsemester/materials/lecture2.pdf'
  },
  {
    "name": "Insurance Policy 2023",
    "date": "Nov 2, 2023",
    "file": 'https://web.mit.edu/6.829/www/currentsemester/materials/lecture1.pdf'
  },
  {
    "name": "Car Loan Agreement",
    "date": "Oct 22, 2023",
    "file": 'https://web.mit.edu/6.829/www/currentsemester/materials/lecture2.pdf'
  },
  {
    "name": "Investment Portfolio - Q3 2023",
    "date": "Oct 10, 2023",
    "file": 'https://web.mit.edu/6.829/www/currentsemester/materials/lecture1.pdf'
  },
  {
    "name": "Tax Filing - 2023",
    "date": "Sep 28, 2023",
    "file": 'https://web.mit.edu/6.829/www/currentsemester/materials/lecture2.pdf'
  },
  {
    "name": "House Lease Contract",
    "date": "Sep 15, 2023",
    "file": 'https://web.mit.edu/6.829/www/currentsemester/materials/lecture1.pdf'
  },
];

List<PdfData> pdfFileList = pdfFiles.map((json) {
  return PdfData(
    name: json['name']!,
    date: json['date']!,
    file: json['file']!,
  );
}).toList();
