import 'dart:developer';
import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:traderapp/api/pdf_api.dart';
import 'package:traderapp/models/current_userdetails.dart';
import 'package:traderapp/models/invoiceitem.dart';
import 'package:traderapp/models/user.dart';

class PdfApiGenerate {
  static Future<File> generate(
      List<InvoiceItem> items, Map<String, dynamic> orderdatauser,MyUser user) async {
    final font = await PdfGoogleFonts.openSansLight();
    final name = DateTime.now().microsecondsSinceEpoch.toString();
    log(orderdatauser.toString());
    log(user.name);

    final pdf = Document(theme: ThemeData.withFont(base: font));
    pdf.addPage(MultiPage(
      build: (Context context) {
        return [
          buildHeader(orderdatauser,user),
          buildInvoice(),
          buildtable(items),
          buildTotal(items)
        ];
      },
    ));
    return await PdfApi.saveDocument(name: '$name.pdf', pdf: pdf);
  }

  static Widget buildHeader(Map<String, dynamic> orderdatauser,MyUser user) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Order From: ${orderdatauser['name']}'),
              Text('Address: ${orderdatauser['address']}'),
              Text('Order Data User: ${orderdatauser['name']}'),
              Text('Phone Number: ${orderdatauser['phno']}'),
              SizedBox(height: 10),
              Text('Order to: ${user.name}'),
              Text('Address: ${user.address}'),
              Text('Company: ${user.company}'),
              Text('Phone Number: ${user.phno}'),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Invoice Date: ${DateTime.now()}'),
            Text('Due Date: ${DateTime.now().add(const Duration(days: 7))}'),
          ],
        ),
      ],
    );
  }

  static Widget buildInvoice() {
    return Column(
      children: [
        SizedBox(height: 40.0),
        Text('Invoice',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ],
    );
  }

  static Widget buildtable(List<InvoiceItem> items) {
    final headers = ['product name', 'price', 'quantity', 'subtotal'];
    final data = items.map((e) {
      return [e.name, e.price, e.quantity, e.price * e.quantity];
    }).toList();
    return TableHelper.fromTextArray(
      headers: headers,
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
      },
    );
  }

  static Widget buildTotal(List<InvoiceItem> items) {
    double total = 0;
    items.forEach((item) {
      total += item.price * item.quantity;
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Text('Total: \$${total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
