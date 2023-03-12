// import 'dart:io';
// import 'package:flutter/material.dart' as material;
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart' as form_builder;
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;
// import 'package:pdf/pdf.dart' as pdf;
// import 'package:pdf/widgets.dart' as pdf_widgets;


// class ResumeGenerator extends StatefulWidget {
//   @override
//   _ResumeGeneratorState createState() => _ResumeGeneratorState();
// }

// class _ResumeGeneratorState extends State<ResumeGenerator> {
//   final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
//   bool _isLoading = false;
//   String _pdfPath = '';

//   Future<void> _generatePdf() async {
//     if (!_formKey.currentState!.saveAndValidate()) {
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     final pdf.Document pdfDocument = pdf.Document();
//     final pdf_widgets.Page page = pdf_widgets.Page(
//       pageFormat: pdf.PdfPageFormat.a4,
//       build: (pdf_widgets.Context context) {
//         return pdf_widgets.Column(
//           crossAxisAlignment: pdf_widgets.CrossAxisAlignment.start,
//           children: [
//             pdf_widgets.Text(
//               _formKey.currentState!.fields['name']!.value.toString(),
//               style: pdf.TextStyle(
//                 fontSize: 20,
//                 fontWeight: pdf.FontWeight.bold,
//               ),
//             ),
//             pdf_widgets.SizedBox(height: 10),
//             pdf_widgets.Text(
//               _formKey.currentState!.fields['email']!.value.toString(),
//               style: pdf.TextStyle(
//                 fontSize: 14,
//               ),
//             ),
//             pdf_widgets.SizedBox(height: 10),
//             pdf_widgets.Text(
//               _formKey.currentState!.fields['phone']!.value.toString(),
//               style: pdf.TextStyle(
//                 fontSize: 14,
//               ),
//             ),
//             pdf_widgets.SizedBox(height: 20),
//             pdf_widgets.Text(
//               'Work Experience',
//               style: pdf.TextStyle(
//                 fontSize: 16,
//                 fontWeight: pdf.FontWeight.bold,
//               ),
//             ),
//             pdf_widgets.SizedBox(height: 10),
//             pdf_widgets.Text(
//               _formKey.currentState!.fields['workExperience']!.value.toString(),
//               style: pdf.TextStyle(
//                 fontSize: 14,
//               ),
//             ),
//             pdf_widgets.SizedBox(height: 20),
//             pdf_widgets.Text(
//               'Education',
//               style: pdf.TextStyle(
//                 fontSize: 16,
//                 fontWeight: pdf.FontWeight.bold,
//               ),
//             ),
//             pdf_widgets.SizedBox(height: 10),
//             pdf_widgets.Text(
//               _formKey.currentState!.fields['education']!.value.toString(),
//               style: pdf.TextStyle(
//                 fontSize: 14,
//               ),
//             ),
//             pdf_widgets.SizedBox(height: 20),
//             pdf_widgets.Text(
//               'Skills',
//               style: pdf.TextStyle(
//                 fontSize: 16,
//                 fontWeight: pdf.FontWeight.bold,
//               ),
//             ),
//             pdf_widgets.SizedBox(height: 10),
//             pdf_widgets.Text(
//               _formKey.currentState!.fields['skills']!.value.toString(),
//               style: pdf.TextStyle(
//                 fontSize: 14,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//     pdfDocument.addPage(page);

//     final Directory directory = await path_provider.getApplicationDocumentsDirectory();
//     final String documentPath = directory.path;
//     final String pdfPath = '$documentPath/resume.pdf';
//     final File file = File(pdfPath);
//     await file.writeAsBytes(await pdfDocument.save());

//     setState(() {
//       _pdfPath = pdf



// siddushetty30@gmail.com
// please continue the code
// Sorry about that, here's the rest of the code:

// less
// Copy code
//       _isLoading = false;
//     });
//   }

//   Future<void> _sharePdf() async {
//     if (_pdfPath.isEmpty) {
//       return;
//     }

//     await share.Share.shareFiles([_pdfPath], text: 'Resume');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return material.Scaffold(
//       appBar: material.AppBar(
//         title: const Text('Resume Generator'),
//       ),
//       body: material.FormBuilder(
//         key: _formKey,
//         child: material.Padding(
//           padding: const EdgeInsets.all(10),
//           child: material.ListView(
//             children: [
//               form_builder.FormBuilderTextField(
//                 name: 'name',
//                 decoration: const InputDecoration(
//                   labelText: 'Name',
//                 ),
//                 validator: form_builder.FormBuilderValidators.required(context),
//               ),
//               form_builder.FormBuilderTextField(
//                 name: 'email',
//                 decoration: const InputDecoration(
//                   labelText: 'Email',
//                 ),
//                 validator: form_builder.FormBuilderValidators.compose([
//                   form_builder.FormBuilderValidators.required(context),
//                   form_builder.FormBuilderValidators.email(context),
//                 ]),
//               ),
//               form_builder.FormBuilderTextField(
//                 name: 'phone',
//                 decoration: const InputDecoration(
//                   labelText: 'Phone',
//                 ),
//                 validator: form_builder.FormBuilderValidators.compose([
//                   form_builder.FormBuilderValidators.required(context),
//                   form_builder.FormBuilderValidators.numeric(context),
//                 ]),
//               ),
//               form_builder.FormBuilderTextField(
//                 name: 'workExperience',
//                 decoration: const InputDecoration(
//                   labelText: 'Work Experience',
//                 ),
//                 validator: form_builder.FormBuilderValidators.required(context),
//               ),
//               form_builder.FormBuilderTextField(
//                 name: 'education',
//                 decoration: const InputDecoration(
//                   labelText: 'Education',
//                 ),
//                 validator: form_builder.FormBuilderValidators.required(context),
//               ),
//               form_builder.FormBuilderTextField(
//                 name: 'skills',
//                 decoration: const InputDecoration(
//                   labelText: 'Skills',
//                 ),
//                 maxLines: 3,
//                 validator: form_builder.FormBuilderValidators.required(context),
//               ),
//               material.SizedBox(height: 20),
//               material.ElevatedButton(
//                 onPressed: _isLoading ? null : _generatePdf,
//                 child: _isLoading ? const CircularProgressIndicator() : const Text('Generate PDF'),
//               ),
//               if (_pdfPath.isNotEmpty)
//                 material.SizedBox(
//                   height: 40,
//                   child: material.Row(
//                     children: [
//                       material.Expanded(
//                         child: material.Text(
//                           'PDF generated successfully',
//                           style: material.TextStyle(
//                             fontWeight: material.FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       material.OutlinedButton(
//                         onPressed: _sharePdf,
//                         child: const Text('Share'),
//                       ),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }