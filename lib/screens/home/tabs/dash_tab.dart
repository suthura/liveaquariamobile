import 'package:aquaria_mobile/utils/color_constants.dart';
import 'package:flutter/material.dart';
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
    _tooltipBehavior = TooltipBehavior(enable: true, format: 'point.x : point.y%');
    dataSources = <ChartSampleData>[
      ChartSampleData(x: 'Pending', y: 62.70, text: '30%', pointColor: const Color.fromRGBO(69, 186, 161, 1.0)),
      ChartSampleData(x: 'Approved', y: 29.20, text: '50%', pointColor: const Color.fromRGBO(230, 135, 111, 1.0)),
      ChartSampleData(x: 'Rejected', y: 85.20, text: '20%', pointColor: const Color.fromRGBO(145, 132, 202, 1.0))
    ];
    _annotationSources = <CircularChartAnnotation>[
      CircularChartAnnotation(
        widget: Icon(
          Icons.pending,
          color: const Color.fromRGBO(69, 186, 161, 1.0),
          size: 20,
        ),
        // widget: Image.asset(
        //   'images/car_legend.png',
        //   width: 20,
        //   height: 20,
        //   color: const Color.fromRGBO(69, 186, 161, 1.0),
        // ),
      ),
      CircularChartAnnotation(
        widget: Icon(
          Icons.approval,
          color: const Color.fromRGBO(230, 135, 111, 1.0),
          size: 20,
        ),
        // widget: Image.asset(
        //   'images/book.png',
        //   width: 20,
        //   height: 20,
        //   color: const Color.fromRGBO(230, 135, 111, 1.0),
        // ),
      ),
      CircularChartAnnotation(
        widget: Icon(
          Icons.close,
          color: const Color.fromRGBO(235, 96, 143, 1.0),
          size: 20,
        ),
        // widget: Image.asset(
        //   'images/personal_loan.png',
        //   width: 20,
        //   height: 20,
        //   color: const Color.fromRGBO(235, 96, 143, 1.0),
        // ),
      ),
    ];
    colors = const <Color>[
      Color.fromRGBO(69, 186, 161, 1.0),
      Color.fromRGBO(230, 135, 111, 1.0),
      Color.fromRGBO(145, 132, 202, 1.0),
      Color.fromRGBO(235, 96, 143, 1.0)
    ];

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
          child: SfCircularChart(
            legend: Legend(
              position: LegendPosition.bottom,
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
              // legendItemBuilder: (String name, dynamic series, dynamic point, int index) {
              //   return SizedBox(
              //     // height: 100,
              //     width: 150,
              //     child: Row(
              //       children: <Widget>[
              //         SizedBox(
              //             height: 75,
              //             width: 65,
              //             child: SfCircularChart(
              //               annotations: <CircularChartAnnotation>[
              //                 _annotationSources![index],
              //               ],
              //               series: <PieSeries<ChartSampleData, String>>[
              //                 PieSeries<ChartSampleData, String>(
              //                     animationDuration: 0,
              //                     dataSource: <ChartSampleData>[dataSources![index]],
              //                     xValueMapper: (ChartSampleData data, _) => point.x as String,
              //                     yValueMapper: (ChartSampleData data, _) => data.y,
              //                     pointColorMapper: (ChartSampleData data, _) => data.pointColor,
              //                     pointRadiusMapper: (ChartSampleData data, _) => data.text),
              //               ],
              //             )),
              //         SizedBox(
              //             width: 72,
              //             child: Text(
              //               point.x,
              //               style: TextStyle(color: colors![index], fontWeight: FontWeight.bold),
              //             )),
              //       ],
              //     ),
              //   );
              // },
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
                  ChartSampleData(x: 'Approved', y: 4, text: '30%', pointColor: Color.fromARGB(255, 161, 186, 69)),
                  ChartSampleData(x: 'Pending', y: 8, text: '50%', pointColor: const Color.fromRGBO(230, 135, 111, 1.0)),
                  ChartSampleData(x: 'Rejected', y: 2, text: '10%', pointColor: Color.fromARGB(255, 173, 62, 47)),
                ],
                pointColorMapper: (ChartSampleData data, _) => data.pointColor,
                xValueMapper: (ChartSampleData data, _) => data.x,
                yValueMapper: (ChartSampleData data, _) => data.y,
              )
              // Renders radial bar chart
              // PieSeries<ChartSampleData, String>(
              //   animationDuration: 0,
              //   // maximumValue: 100,
              //   // gap: '10%',
              //   // radius: '100%',
              //   dataSource: <ChartSampleData>[
              //     ChartSampleData(x: 'Pending', y: 62.70, text: '30%', pointColor: const Color.fromRGBO(69, 186, 161, 1.0)),
              //     ChartSampleData(x: 'Approved', y: 29.20, text: '50%', pointColor: const Color.fromRGBO(230, 135, 111, 1.0)),
              //     ChartSampleData(x: 'Rejected', y: 85.20, text: '20%', pointColor: const Color.fromRGBO(145, 132, 202, 1.0))
              //   ],
              //   // cornerStyle: CornerStyle.bothCurve,
              //   xValueMapper: (ChartSampleData data, _) => data.x as String,
              //   yValueMapper: (ChartSampleData data, _) => data.y,
              //   pointRadiusMapper: (ChartSampleData data, _) => data.text,

              //   /// Color mapper for each bar in radial bar series,
              //   /// which is get from datasource.
              //   pointColorMapper: (ChartSampleData data, _) => data.pointColor,
              //   legendIconType: LegendIconType.circle,
              // )
            ],
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
