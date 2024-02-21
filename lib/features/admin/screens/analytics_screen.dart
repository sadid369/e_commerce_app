import 'package:e_commerce_app/common/widgets/loader.dart';
import 'package:e_commerce_app/features/admin/models/sales.dart';
import 'package:e_commerce_app/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  num? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : SafeArea(
            child: Center(
              child: Container(
                child: SfCartesianChart(
                  // Initialize category axis
                  title: const ChartTitle(text: 'Category wise sales data'),
                  primaryXAxis: const CategoryAxis(),
                  primaryYAxis: NumericAxis(
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                    title: AxisTitle(text: 'Total Sales in USd'),
                  ),

                  series: <BarSeries<Sales, String>>[
                    BarSeries<Sales, String>(
                      // Bind data source
                      dataSource: earnings,
                      xValueMapper: (Sales sales, _) => sales.label,
                      yValueMapper: (Sales sales, _) => sales.earnings,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
