import 'package:aquaria_mobile/providers/item_order_provider.dart';
import 'package:aquaria_mobile/utils/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({
    super.key,
  });

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  TooltipBehavior? _tooltipBehavior;

  List<ChartSampleData>? dataSources;

  List<CircularChartAnnotation>? _annotationSources;

  List<Color>? colors;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ItemOrderProvider>(context, listen: false).loadSupplierRequests(context);
    });
    // _tooltipBehavior = TooltipBehavior(enable: true, format: 'point.x : point.y%');
    // dataSources = <ChartSampleData>[
    //   ChartSampleData(x: 'Pending', y: 62.70, text: '30%', pointColor: const Color.fromRGBO(69, 186, 161, 1.0)),
    //   ChartSampleData(x: 'Approved', y: 29.20, text: '50%', pointColor: const Color.fromRGBO(230, 135, 111, 1.0)),
    //   ChartSampleData(x: 'Rejected', y: 85.20, text: '20%', pointColor: const Color.fromRGBO(145, 132, 202, 1.0))
    // ];
    // _annotationSources = <CircularChartAnnotation>[
    //   CircularChartAnnotation(
    //     widget: Icon(
    //       Icons.pending,
    //       color: const Color.fromRGBO(69, 186, 161, 1.0),
    //       size: 20,
    //     ),
    //   ),
    //   CircularChartAnnotation(
    //     widget: Icon(
    //       Icons.approval,
    //       color: const Color.fromRGBO(230, 135, 111, 1.0),
    //       size: 20,
    //     ),
    //   ),
    //   CircularChartAnnotation(
    //     widget: Icon(
    //       Icons.close,
    //       color: const Color.fromRGBO(235, 96, 143, 1.0),
    //       size: 20,
    //     ),
    //   ),
    // ];
    // colors = const <Color>[
    //   Color.fromRGBO(69, 186, 161, 1.0),
    //   Color.fromRGBO(230, 135, 111, 1.0),
    //   Color.fromRGBO(145, 132, 202, 1.0),
    //   Color.fromRGBO(235, 96, 143, 1.0)
    // ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: kTxtWhite,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.6),
            borderRadius: BorderRadius.circular(12),
          ),
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.height * .6,
          child: Consumer<ItemOrderProvider>(
            builder: (context, itmOrd, child) {
              if (itmOrd.getisLoadingSupReq) {
                return CupertinoActivityIndicator();
              }
              return SfCircularChart(
                legend: Legend(
                  position: LegendPosition.bottom,
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                ),
                series: <CircularSeries>[
                  PieSeries<ChartSampleData, String>(
                    explode: true,
                    dataLabelMapper: (datum, index) {
                      return datum.y.toStringAsFixed(0);
                    },
                    dataLabelSettings: DataLabelSettings(
                      margin: EdgeInsets.zero,
                      isVisible: true,
                      textStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      labelPosition: ChartDataLabelPosition.outside,
                      connectorLineSettings: const ConnectorLineSettings(
                        type: ConnectorType.curve,
                        length: '10%',
                      ),
                    ),
                    dataSource: <ChartSampleData>[
                      ChartSampleData(
                        x: 'Approved',
                        y: double.parse(itmOrd.getSeperateSupReq(approval: 'approved', published: [0]).length.toString()),
                        text: '',
                        pointColor: Color.fromARGB(255, 161, 186, 69),
                      ),
                      ChartSampleData(
                          x: 'Pending',
                          y: double.parse(itmOrd.getSeperateSupReq(approval: 'pending', published: [0]).length.toString()),
                          text: '',
                          pointColor: const Color.fromRGBO(230, 135, 111, 1.0)),
                      ChartSampleData(
                          x: 'Rejected',
                          y: double.parse(itmOrd.getSeperateSupReq(approval: 'rejected', published: [0, 1]).length.toString()),
                          text: '',
                          pointColor: Color.fromARGB(255, 173, 62, 47)),
                      ChartSampleData(
                          x: 'Published',
                          y: double.parse(itmOrd.getSeperateSupReq(approval: 'approved', published: [1]).length.toString()),
                          text: '',
                          pointColor: Color.fromARGB(255, 81, 47, 173)),
                    ],
                    pointColorMapper: (ChartSampleData data, _) => data.pointColor,
                    xValueMapper: (ChartSampleData data, _) => data.x,
                    yValueMapper: (ChartSampleData data, _) => data.y,
                  )
                ],
              );
            },
          ),
        )
      ],
    );
  }
}

class ChartSampleData {
  String x;
  double y;
  String text;
  Color pointColor;

  ChartSampleData({
    required this.x,
    required this.y,
    required this.text,
    required this.pointColor,
  });
}
