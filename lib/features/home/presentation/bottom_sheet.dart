import 'package:domi_labs/features/home/presentation/pdf_list_item.dart';
import 'package:domi_labs/styling/app_colors.dart';
import 'package:domi_labs/styling/app_text_styles.dart';
import 'package:domi_labs/utilities/pdf_data.dart';
import 'package:flutter/material.dart';

class MapBottomSheet extends StatelessWidget {
  const MapBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.1,
      minChildSize: 0.1,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          physics: const ClampingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 3,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.grey,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'dõmi in',
                              style: AppTextStyle.whiteBold16,
                            ),
                            Icon(Icons.arrow_forward_ios_rounded,
                                size: 10, color: Colors.white),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/images/car0${index + 1}.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.grey,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'dõmi docs',
                              style: AppTextStyle.whiteBold16,
                            ),
                            Icon(Icons.arrow_forward_ios_rounded,
                                size: 10, color: Colors.white),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          style: AppTextStyle.whiteRegular12,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.white70),
                            hintText: 'Search docs',
                            hintStyle: AppTextStyle.whiteMedium16
                                .copyWith(color: Colors.white70),
                            filled: true,
                            fillColor: Colors.grey[800],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: pdfFileList.length,
                          itemBuilder: (context, index) {
                            final pdf = pdfFileList[index];
                            return PDFListItem(
                              pdfData: pdf
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

