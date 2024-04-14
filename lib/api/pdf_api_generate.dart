import 'dart:developer';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:traderapp/api/pdf_api.dart';
import 'package:traderapp/models/invoiceitem.dart';

class PdfApiGenerate{
  
 static Future generate(List<InvoiceItem> items) async{
  final font = await PdfGoogleFonts.openSansLight();
  final name= DateTime.now().microsecondsSinceEpoch.toString();
  log(name);
    final pdf=Document(theme: ThemeData.withFont(base: font));
    pdf.addPage(MultiPage(build: (Context context) {
      return [buildtable(items)];
    },));
    return await PdfApi.saveDocument(name: '$name.pdf', pdf: pdf);
  }
  
  static buildtable(List<InvoiceItem> items) {
    final headers=['product name','price','quantity','subtotal'];
    final data= items.map((e) {return [e.name,e.price,e.quantity,e.price*e.quantity];}).toList();
    return TableHelper.fromTextArray(headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        
      }, );
  }
}