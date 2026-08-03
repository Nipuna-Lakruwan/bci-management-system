import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:printing/printing.dart';
import '../../core/utils/pdf_generator.dart';
import '../../features/employees/domain/employee.dart';
import '../../features/employees/controller/employee_controller.dart';

class PayrollScreen extends StatefulWidget {
  const PayrollScreen({super.key});

  @override
  State<PayrollScreen> createState() => _PayrollScreenState();
}

class _PayrollScreenState extends State<PayrollScreen> {
  
  double _getMonthlyPayrollTotal(List<Employee> employees) {
    double total = 0;
    for (final emp in employees) {
      total += emp.netSalary;
    }
    return total;
  }

  void _confirmDelete(BuildContext context, Employee employee) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Remove employee'),
        content: Text('Remove ${employee.name} from the payroll records?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<EmployeeController>().deleteEmployee(employee.id);
    }
  }

  void _showPayslip(BuildContext context, Employee employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Payslip - ${employee.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Employee ID: ${employee.id}'),
            Text('Designation: ${employee.designation}'),
            const Divider(),
            _SalaryRow(label: 'Gross Salary', value: employee.grossSalary, bold: true),
            _SalaryRow(label: 'Total Deductions', value: employee.totalDeductions, bold: true),
            const Divider(),
            _SalaryRow(label: 'NET PAY', value: employee.netSalary, bold: true),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          FilledButton.icon(
            onPressed: () async {
              Navigator.pop(context);
              final pdfBytes = await PdfGenerator.generatePayslip(employee);
              await Printing.layoutPdf(
                onLayout: (format) async => pdfBytes,
                name: 'Payslip_${employee.id}.pdf',
              );
            },
            icon: const Icon(Icons.print),
            label: const Text('Print Payslip'),
          ),
        ],
      ),
    );
  }

  static String _money(double value) => 'LKR ${value.toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    final employees = context.watch<EmployeeController>().employees;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payroll Management'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        children: <Widget>[
          Text(
            'Monthly salary calculation for BCI employees',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 18),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.payments_outlined, size: 38),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('Total Net Payroll'),
                        Text(
                          _money(_getMonthlyPayrollTotal(employees)),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          ...employees.map(
            (Employee employee) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                child: ExpansionTile(
                  leading: const CircleAvatar(child: Icon(Icons.badge_outlined)),
                  title: Text(
                    employee.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    '${employee.id} • ${employee.designation}\n${employee.department}',
                  ),
                  childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
                  children: <Widget>[
                    _SalaryRow(label: 'Basic Salary', value: employee.basicSalary),
                    _SalaryRow(label: 'Allowances', value: employee.allowances),
                    _SalaryRow(label: 'Overtime', value: employee.overtime),
                    const Divider(),
                    _SalaryRow(
                      label: 'Gross Salary',
                      value: employee.grossSalary,
                      bold: true,
                    ),
                    _SalaryRow(label: 'Other Deductions', value: employee.deductions),
                    _SalaryRow(label: 'Tax', value: employee.tax),
                    const Divider(),
                    _SalaryRow(
                      label: 'Net Salary',
                      value: employee.netSalary,
                      bold: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () => _confirmDelete(context, employee),
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          label: const Text('Remove', style: TextStyle(color: Colors.red)),
                        ),
                        const SizedBox(width: 8),
                        FilledButton.icon(
                          onPressed: () => _showPayslip(context, employee),
                          icon: const Icon(Icons.receipt_long),
                          label: const Text('Payslip'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SalaryRow extends StatelessWidget {
  const _SalaryRow({
    required this.label,
    required this.value,
    this.bold = false,
  });

  final String label;
  final double value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final TextStyle? style = bold
        ? Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            )
        : Theme.of(context).textTheme.bodyMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(label, style: style)),
          Text('LKR ${value.toStringAsFixed(2)}', style: style),
        ],
      ),
    );
  }
}
