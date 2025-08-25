// import 'package:flutter/material.dart';
//
// class FullScreenImageViewer extends StatelessWidget {
//   final String imageUrl;
//
//   const FullScreenImageViewer({super.key, required this.imageUrl});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: const Padding(
//           padding: EdgeInsets.all(16),
//           child: BackIcon(),
//         ),
//       ),
//       body: GestureDetector(
//         onTap: () => Navigator.pop(context),
//         child: Center(
//           child: InteractiveViewer(
//             child: CachedNetworkImage(
//               imageUrl: imageUrl,
//               fit: BoxFit.contain,
//               errorWidget: (context, url, error) =>
//                   const Icon(Icons.error, color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
