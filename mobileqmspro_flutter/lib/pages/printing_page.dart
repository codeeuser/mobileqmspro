import 'package:flutter/material.dart';
import 'package:mobileqmspro/commons/custom_appbar.dart';
import 'package:mobileqmspro/generated/l10n.dart';
import 'package:mobileqmspro/utils/functions.dart';
import 'package:printing/printing.dart';

class PrintingPage extends StatefulWidget {
  final String text;
  const PrintingPage({super.key, required this.text});

  @override
  State<PrintingPage> createState() => _PrintingPageState();
}

class _PrintingPageState extends State<PrintingPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: CustomAppBar(
          label: S.of(context).title,
          title: Utils.getAppBarTitle(
              S.of(context).printToken.toUpperCase(), context),
          goBackButton: Utils.goBackButton(() => Navigator.pop(context)),
        ),
        body: PdfPreview(
          build: (format) => Utils.generatePdf(format, widget.text),
        ),
      ),
    );
  }
}
