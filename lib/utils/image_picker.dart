// // Copyright 2013 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// // ignore_for_file: public_member_api_docs

// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mime/mime.dart';

// class ImagePickerr extends StatefulWidget {
//   const ImagePickerr({super.key});

//   @override
//   State<ImagePickerr> createState() => _ImagePickerrState();
// }

// class _ImagePickerrState extends State<ImagePickerr> {
//   List<XFile>? _mediaFileList;

//   void _setImageFileListFromFile(XFile? value) {
//     _mediaFileList = value == null ? null : <XFile>[value];
//   }

//   dynamic _pickImageError;
//   String? _retrieveDataError;

//   final ImagePicker _picker = ImagePicker();

//   Future<void> _onImageButtonPressed(
//     ImageSource source, {
//     required BuildContext context,
//   }) async {
//     if (context.mounted) {
//       await _displayPickImageDialog(context,
//           (double? maxWidth, double? maxHeight, int? quality) async {
//         try {
//           final XFile? pickedFile = await _picker.pickImage(
//             source: source,
//             maxWidth: maxWidth,
//             maxHeight: maxHeight,
//             imageQuality: quality,
//           );
//           setState(() {
//             _setImageFileListFromFile(pickedFile);
//           });
//         } catch (e) {
//           setState(() {
//             _pickImageError = e;
//           });
//         }
//       });
//       // }
//     }
//   }

//   @override
//   void deactivate() {
//     super.deactivate();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   Widget _previewImages() {
//     final Text? retrieveError = _getRetrieveErrorWidget();
//     if (retrieveError != null) {
//       return retrieveError;
//     }
//     if (_mediaFileList != null) {
//       return Semantics(
//         label: 'image_picker_example_picked_images',
//         child: ListView.builder(
//           key: UniqueKey(),
//           itemBuilder: (BuildContext context, int index) {
//             final String? mime = lookupMimeType(_mediaFileList![index].path);

//             // Why network for web?
//             // See https://pub.dev/packages/image_picker_for_web#limitations-on-the-web-platform
//             return Semantics(
//               label: 'image_picker_example_picked_image',
//               child: kIsWeb
//                   ? Image.network(_mediaFileList![index].path)
//                   : (mime == null || mime.startsWith('image/')
//                       ? Image.file(
//                           File(_mediaFileList![index].path),
//                           errorBuilder: (BuildContext context, Object error,
//                               StackTrace? stackTrace) {
//                             return const Center(
//                                 child:
//                                     Text('This image type is not supported'));
//                           },
//                         )
//                       : SizedBox.shrink()),
//             );
//           },
//           itemCount: _mediaFileList!.length,
//         ),
//       );
//     } else if (_pickImageError != null) {
//       return Text(
//         'Pick image error: $_pickImageError',
//         textAlign: TextAlign.center,
//       );
//     } else {
//       return const Text(
//         'You have not yet picked an image.',
//         textAlign: TextAlign.center,
//       );
//     }
//   }

//   Widget _handlePreview() {
//     return _previewImages();
//   }

//   Future<void> retrieveLostData() async {
//     final LostDataResponse response = await _picker.retrieveLostData();
//     if (response.isEmpty) {
//       return;
//     }
//     if (response.file != null) {
//       setState(() {
//         if (response.files == null) {
//           _setImageFileListFromFile(response.file);
//         } else {
//           _mediaFileList = response.files;
//         }
//       });
//     } else {
//       _retrieveDataError = response.exception!.code;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
//             ? FutureBuilder<void>(
//                 future: retrieveLostData(),
//                 builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//                   switch (snapshot.connectionState) {
//                     case ConnectionState.none:
//                     case ConnectionState.waiting:
//                       return const Text(
//                         'You have not yet picked an image.',
//                         textAlign: TextAlign.center,
//                       );
//                     case ConnectionState.done:
//                       return _handlePreview();
//                     case ConnectionState.active:
//                       if (snapshot.hasError) {
//                         return Text(
//                           'Pick image/video error: ${snapshot.error}}',
//                           textAlign: TextAlign.center,
//                         );
//                       } else {
//                         return const Text(
//                           'You have not yet picked an image.',
//                           textAlign: TextAlign.center,
//                         );
//                       }
//                   }
//                 },
//               )
//             : _handlePreview(),
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           Semantics(
//             label: 'image_picker_example_from_gallery',
//             child: FloatingActionButton(
//               onPressed: () {
//                 _onImageButtonPressed(ImageSource.gallery, context: context);
//               },
//               heroTag: 'image0',
//               tooltip: 'Pick Image from gallery',
//               child: const Icon(Icons.photo),
//             ),
//           ),
//           // Padding(
//           //   padding: const EdgeInsets.only(top: 16.0),
//           //   child: FloatingActionButton(
//           //     onPressed: () {
//           //       _onImageButtonPressed(
//           //         ImageSource.gallery,
//           //         context: context,
//           //         isMultiImage: true,
//           //         isMedia: true,
//           //       );
//           //     },
//           //     heroTag: 'multipleMedia',
//           //     tooltip: 'Pick Multiple Media from gallery',
//           //     child: const Icon(Icons.photo_library),
//           //   ),
//           // ),
//           // Padding(
//           //   padding: const EdgeInsets.only(top: 16.0),
//           //   child: FloatingActionButton(
//           //     onPressed: () {
//           //       _onImageButtonPressed(
//           //         ImageSource.gallery,
//           //         context: context,
//           //         isMedia: true,
//           //       );
//           //     },
//           //     heroTag: 'media',
//           //     tooltip: 'Pick Single Media from gallery',
//           //     child: const Icon(Icons.photo_library),
//           //   ),
//           // ),
//           // Padding(
//           //   padding: const EdgeInsets.only(top: 16.0),
//           //   child: FloatingActionButton(
//           //     onPressed: () {
//           //       _onImageButtonPressed(
//           //         ImageSource.gallery,
//           //         context: context,
//           //         isMultiImage: true,
//           //       );
//           //     },
//           //     heroTag: 'image1',
//           //     tooltip: 'Pick Multiple Image from gallery',
//           //     child: const Icon(Icons.photo_library),
//           //   ),
//           // ),
//           if (_picker.supportsImageSource(ImageSource.camera))
//             Padding(
//               padding: const EdgeInsets.only(top: 16.0),
//               child: FloatingActionButton(
//                 onPressed: () {
//                   _onImageButtonPressed(ImageSource.camera, context: context);
//                 },
//                 heroTag: 'image2',
//                 tooltip: 'Take a Photo',
//                 child: const Icon(Icons.camera_alt),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Text? _getRetrieveErrorWidget() {
//     if (_retrieveDataError != null) {
//       final Text result = Text(_retrieveDataError!);
//       _retrieveDataError = null;
//       return result;
//     }
//     return null;
//   }

//   Future<void> _displayPickImageDialog(
//       BuildContext context, OnPickImageCallback onPick) async {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Add optional parameters'),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text('CANCEL'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               TextButton(
//                   child: const Text('PICK'),
//                   onPressed: () {
//                     onPick(null, null, null);
//                     Navigator.of(context).pop();
//                   }),
//             ],
//           );
//         });
//   }
// }

// typedef OnPickImageCallback = void Function(
//     double? maxWidth, double? maxHeight, int? quality);
