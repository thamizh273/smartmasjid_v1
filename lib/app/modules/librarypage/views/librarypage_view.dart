import 'package:flutter/material.dart';

import '../../../../widgets/button_widget.dart';
import '../../../../widgets/title_widget.dart';
import '../../membership/model/pdf_model/customer.dart';
import '../../membership/model/pdf_model/invoice.dart';
import '../../membership/model/pdf_model/supplier.dart';
import '../../membership/pdf_helper/pdf_helper.dart';
import '../../membership/pdf_helper/pdf_invoice_helper.dart';


class LibrarypageView extends StatefulWidget {
  const LibrarypageView({super.key});

  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<LibrarypageView> {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color.fromARGB(66, 196, 194, 194),
    appBar: AppBar(
      title: const Text("hi"),
      centerTitle: true,
    ),
    body: Container(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TitleWidget(
              icon: Icons.picture_as_pdf,
              text: 'Generate Invoice',
            ),
            const SizedBox(height: 48),
            ButtonWidget(
              text: 'Get PDF',
              onClicked: () async {
                final date = DateTime.now();
                final dueDate = date.add(
                  const Duration(days: 7),
                );

                final invoice = Invoice(
                  supplier: const Supplier(
                    name: 'Faysal Neowaz',
                    address: 'Dhaka, Bangladesh',
                    paymentInfo: 'https://paypal.me/codespec',
                  ),
                  customer: const Customer(
                    name: 'Google',
                    address: 'Mountain View, California, United States',
                  ),
                  info: InvoiceInfo(
                    date: date,
                    dueDate: dueDate,
                    description: 'First Order Invoice',
                    number: '${DateTime.now().year}-9999',
                  ),
                  items: [
                    InvoiceItem(
                      description: 'Coffee',
                      date: DateTime.now(),
                      quantity: 3,
                      vat: 0.19,
                      unitPrice: 5.99,
                    ),
                    InvoiceItem(
                      description: 'Water',
                      date: DateTime.now(),
                      quantity: 8,
                      vat: 0.19,
                      unitPrice: 0.99,
                    ),
                    InvoiceItem(
                      description: 'Orange',
                      date: DateTime.now(),
                      quantity: 3,
                      vat: 0.19,
                      unitPrice: 2.99,
                    ),
                    InvoiceItem(
                      description: 'Apple',
                      date: DateTime.now(),
                      quantity: 8,
                      vat: 0.19,
                      unitPrice: 3.99,
                    ),
                    InvoiceItem(
                      description: 'Mango',
                      date: DateTime.now(),
                      quantity: 1,
                      vat: 0.19,
                      unitPrice: 1.59,
                    ),
                    InvoiceItem(
                      description: 'Blue Berries',
                      date: DateTime.now(),
                      quantity: 5,
                      vat: 0.19,
                      unitPrice: 0.99,
                    ),
                    InvoiceItem(
                      description: 'Lemon',
                      date: DateTime.now(),
                      quantity: 4,
                      vat: 0.19,
                      unitPrice: 1.29,
                    ),
                  ],
                );

                final pdfFile = await PdfInvoicePdfHelper.generate(invoice);

                PdfHelper.openFile(pdfFile);
              },
            ),
          ],
        ),
      ),
    ),
  );
}