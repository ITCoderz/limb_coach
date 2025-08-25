// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:srs_dating_app/widgets/full_screen_image.dart';
//
// class PhotoGridView extends StatelessWidget {
//   final List<String> imageUrls;
//   final double spacing;
//
//   const PhotoGridView({super.key, required this.imageUrls, this.spacing = 10});
//
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: spacing,
//       runSpacing: spacing,
//       children: imageUrls
//           .asMap()
//           .entries
//           .map((entry) => _buildImageTile(entry.key, entry.value, context))
//           .toList(),
//     );
//   }
//
//   Widget _buildImageTile(int index, String url, BuildContext context) {
//     double width;
//     double height;
//
//     if (index == 0 || index == 1) {
//       width = context.width / 2 - 35;
//       height = 211;
//     } else {
//       width = context.width / 3 - 25;
//       height = 135;
//     }
//
//     return InkWell(
//       onTap: () {
//         Get.to(() => FullScreenImageViewer(imageUrl: url));
//       },
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: url.isNotEmpty
//             ? CachedNetworkImage(
//                 imageUrl: url,
//                 width: width,
//                 height: height,
//                 fit: BoxFit.cover,
//                 placeholder: (context, url) => Shimmer.fromColors(
//                   baseColor: Colors.grey.shade300,
//                   highlightColor: Colors.grey.shade100,
//                   child: Container(
//                     width: width,
//                     height: height,
//                     color: Colors.white,
//                   ),
//                 ),
//                 errorWidget: (context, url, error) => Shimmer.fromColors(
//                   baseColor: Colors.grey.shade300,
//                   highlightColor: Colors.grey.shade100,
//                   child: Container(
//                     width: width,
//                     height: height,
//                     color: Colors.white,
//                   ),
//                 ),
//               )
//             : const SizedBox(),
//       ),
//     );
//   }
// }
