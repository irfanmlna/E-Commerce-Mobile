import 'package:project_store/models/model_historypayment.dart';
import 'package:flutter/material.dart';
import 'package:order_tracker/order_tracker.dart';

class TrackingPage extends StatefulWidget {
  final Datum data;
  const TrackingPage(this.data, {super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  int _currentStep = 0;
  // List<Tracking> _trackingData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Load your tracking data here if needed
  }

  List<Step> _buildSteps() {
    return [
      Step(
        title: Text("Alamat Toko"),
        subtitle: Text("jakarta"),
        content: Container(),
        isActive: _currentStep >= 0,
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text("Alamat Rumah"),
        subtitle: Text(widget.data.customerAddress),
        content: Container(),
        isActive: _currentStep >= 1,
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      // Add more steps here if you have more tracking data
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCEFE7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.0),
          ),
          child: AppBar(
            backgroundColor: Color(0xff5B4E3B),
            leading: Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close))),
            title: Text(
              'Order Tracking',
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: Stepper(
                      controlsBuilder:
                          (BuildContext context, ControlsDetails controls) {
                        return Container();
                      },
                      currentStep: _currentStep,
                      onStepTapped: (step) {
                        setState(() {
                          _currentStep = step;
                        });
                      },
                      steps: _buildSteps(),
                      type: StepperType.vertical,
                    ),
                  ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     },
                  //     child: Text(
                  //       'Mark as Done',
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.green,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
