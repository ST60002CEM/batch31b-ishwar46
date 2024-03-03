import 'dart:convert';
import 'dart:io';

import 'package:age_care/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdfx/pdfx.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../config/constants/app_colors.dart';
import '../../utils/size_config.dart';

class QRCodeView extends ConsumerStatefulWidget {
  const QRCodeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QRCodeViewState();
}

class _QRCodeViewState extends ConsumerState<QRCodeView> {
  var decoded = base64.decode(
      "iVBORw0KGgoAAAANSUhEUgAABQAAAAUAAQMAAAAiKm20AAAAAXNSR0IB2cksfwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAANQTFRFAAAAp3o92gAAAAF0Uk5TAEDm2GYAAADfSURBVHic7cEBDQAAAMKg909tDjegAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAODfACUtAAGC9DdsAAAAAElFTkSuQmCC");
  var qrImage;
  final pdf = pw.Document();
  SizeConfig _sizeConfig = SizeConfig();

  @override
  void initState() {
    super.initState();

    EasyLoading.show(status: "Generating QR");
    makePDF().then((_) {
      EasyLoading.dismiss();
      setState(() {});
    }).catchError((error) {
      EasyLoading.showError("Error generating QR: $error");
    });
  }

  makePDF() async {
    final username = await HelperFunctions.getUsernameFromToken();
    pdf.addPage(
      pw.Page(
        build: ((context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.BarcodeWidget(
                  data: "Username: $username",
                  barcode: pw.Barcode.qrCode(),
                  width: 400,
                  height: 400,
                  drawText: false,
                ),
                pw.Text(
                  "$username",
                  style: pw.TextStyle(
                    fontSize: 36,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
    await savePdf();
  }

  Future savePdf() async {
    try {
      var status = await Permission.storage.status;
      if (status.isGranted == false) {
        await Permission.storage.request();
        setState(() {});
      }
      var externalDir = await getExternalStorageDirectory();
      final file = File("${externalDir?.path}/myqrcode.pdf");
      if (!file.existsSync()) {
        await file.writeAsBytes(await pdf.save());
      }
      var path = file.path;
      final document = await PdfDocument.openFile(path);
      final page = await document.getPage(1);
      final pageImage =
          await page.render(width: page.width, height: page.height);
      setState(() {
        qrImage = pageImage!.bytes;
      });
    } catch (ex) {
      EasyLoading.showError("Cannot generate QR");
      print("QR_ERROR" + ex.toString());
    }
  }

  void savePdfToDevice() async {
    try {
      var status = await Permission.storage.status;
      if (status.isGranted == false) {
        await Permission.storage.request();
        setState(() {});
      }
      var externalDir = await getExternalStorageDirectory();
      final file = File("${externalDir?.path}/myqrcode.pdf");
      if (!file.existsSync()) {
        await file.writeAsBytes(await pdf.save());
        EasyLoading.showSuccess("PDF saved successfully");
      } else {
        EasyLoading.showError("PDF already exists");
      }
    } catch (ex) {
      EasyLoading.showError("Error saving PDF: $ex");
      print("PDF_SAVE_ERROR: $ex");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = HelperFunctions.isDarkMode(context);
    _sizeConfig.init(context);
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.dark : AppColors.whiteText,
      appBar: AppBar(
        backgroundColor: isDarkMode ? AppColors.dark : AppColors.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "QR Code",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDarkMode ? AppColors.whiteText : AppColors.whiteText),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: _sizeConfig.screenHeight / 2,
                  margin: const EdgeInsets.symmetric(horizontal: 30.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1.0,
                        style: BorderStyle.solid,
                        color: AppColors.primaryColor),
                  ),
                  child: Center(
                    child: Image.memory(
                      (qrImage != null) ? qrImage : decoded,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Scan the QR code to check in",
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'productSansBold',
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: _sizeConfig.screenWidth / 2,
                  child: ElevatedButton(
                      onPressed: () {
                        savePdfToDevice();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.download),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text("Save PDF"),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
