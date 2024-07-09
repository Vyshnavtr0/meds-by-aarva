import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';

class Cam extends StatefulWidget {
  const Cam({super.key});

  @override
  State<Cam> createState() => _CamState();
}

class _CamState extends State<Cam> {
  final _controller = DocumentScannerController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DocumentScanner(
        controller: _controller,
        generalStyles: const GeneralStyles(
          hideDefaultBottomNavigation: true,
          messageTakingPicture: 'Taking picture of document',
          messageCroppingPicture: 'Cropping picture of document',
          messageEditingPicture: 'Editing picture of document',
          messageSavingPicture: 'Saving picture of document',
          baseColor: Color(0xff04A498),
        ),
        takePhotoDocumentStyle: TakePhotoDocumentStyle(
          top: MediaQuery.of(context).padding.top,
          //hideDefaultButtonTakePicture: true,
          onLoading: const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
          children: [
            // * AppBar

            // Positioned(
            //     bottom: MediaQuery.of(context).padding.bottom + 30,
            //     left: 0,
            //     right: 0,
            //     child: Center(
            //       child: GestureDetector(
            //         onTap: () {
            //           _controller.takePhoto();
            //         },
            //         child: Container(
            //           width: 70,
            //           height: 70,
            //           decoration: BoxDecoration(
            //               color: Colors.white,
            //               borderRadius: BorderRadius.circular(100)),
            //         ),
            //       ),
            //     )),
          ],
        ),
        cropPhotoDocumentStyle: CropPhotoDocumentStyle(
          top: MediaQuery.of(context).padding.top,
          maskColor: const Color(0xff04A498).withOpacity(0.2),
        ),
        editPhotoDocumentStyle: EditPhotoDocumentStyle(
          top: MediaQuery.of(context).padding.top,
        ),
        resolutionCamera: ResolutionPreset.ultraHigh,
        pageTransitionBuilder: (child, animation) {
          final tween = Tween<double>(begin: 0, end: 1);

          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );

          return ScaleTransition(
            scale: tween.animate(curvedAnimation),
            child: child,
          );
        },
        onSave: (Uint8List imageBytes) {},
      ),
    );
  }
}
