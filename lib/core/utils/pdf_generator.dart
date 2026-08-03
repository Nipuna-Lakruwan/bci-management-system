import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../features/employees/domain/employee.dart';

class PdfGenerator {
  static Future<Uint8List> generatePayslip(Employee employee) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text('BCI Management System', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 10),
              pw.Text('OFFICIAL PAYSLIP', style: pw.TextStyle(fontSize: 18, color: PdfColors.grey700)),
              pw.SizedBox(height: 20),
              
              // Employee Info
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey300),
                  color: PdfColors.grey100,
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Employee Name: ${employee.name}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Employee ID: ${employee.id}'),
                    pw.Text('Department: ${employee.department}'),
                    pw.Text('Designation: ${employee.designation}'),
                  ],
                ),
              ),
              pw.SizedBox(height: 30),

              // Salary Breakdown Table
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey400),
                columnWidths: {
                  0: const pw.FlexColumnWidth(2),
                  1: const pw.FlexColumnWidth(1),
                },
                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.blue50),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Earnings & Deductions', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Amount (LKR)', style: pw.TextStyle(fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.right),
                      ),
                    ],
                  ),
                  _buildTableRow('Basic Salary', employee.basicSalary),
                  _buildTableRow('Allowances', employee.allowances),
                  _buildTableRow('Overtime', employee.overtime),
                  _buildTableRow('Gross Salary', employee.grossSalary, isBold: true, bgColor: PdfColors.grey100),
                  _buildTableRow('Other Deductions', employee.deductions),
                  _buildTableRow('Tax', employee.tax),
                  _buildTableRow('Total Deductions', employee.totalDeductions, isBold: true, bgColor: PdfColors.grey100),
                  _buildTableRow('NET PAY', employee.netSalary, isBold: true, bgColor: PdfColors.green50),
                ],
              ),
              
              pw.Spacer(),
              pw.Divider(),
              pw.Text(
                'This is a system generated document and does not require a signature.',
                style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
                textAlign: pw.TextAlign.center,
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static pw.TableRow _buildTableRow(String label, double amount, {bool isBold = false, PdfColor? bgColor}) {
    return pw.TableRow(
      decoration: bgColor != null ? pw.BoxDecoration(color: bgColor) : null,
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(
            label, 
            style: pw.TextStyle(fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal)
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(
            amount.toStringAsFixed(2), 
            style: pw.TextStyle(fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal),
            textAlign: pw.TextAlign.right,
          ),
        ),
      ],
    );
  }
}
