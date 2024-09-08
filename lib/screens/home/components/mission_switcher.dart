import 'package:brain_master/utils/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MissionItem extends StatefulWidget {
  final String mission;
  final bool isSwitched;
  final String docId; // Add the document ID
  final int index;    // Index of the mission in the mission_list

  const MissionItem({
    super.key,
    required this.mission,
    required this.isSwitched,
    required this.docId, // Accept the document ID
    required this.index,  // Pass the index of the mission


  });

  @override
  _MissionItemState createState() => _MissionItemState();
}

class _MissionItemState extends State<MissionItem> {
  late bool _isSwitched;

  @override
  void initState() {
    super.initState();
    _isSwitched = widget.isSwitched;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CText(
            text: widget.mission,
            color: Colors.white,
            fontSize: 12,
          ),
          CustomSwitch(
            value: _isSwitched,
            onChanged: (value) {
              setState(() {
                _isSwitched = value;
              });

              // Fetch the document from Firestore
              FirebaseFirestore.instance
                  .collection('switches')
                  .doc(widget.docId)
                  .get()
                  .then((docSnapshot) {
                if (docSnapshot.exists) {
                  // Get the current mission list
                  List<dynamic> missionList = docSnapshot['mission_list'];

                  // Update the specific index's status
                  missionList[widget.index]['status'] = value;

                  // Save the updated mission list back to Firestore
                  FirebaseFirestore.instance
                      .collection('switches')
                      .doc(widget.docId)
                      .update({'mission_list': missionList});
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.0,
      child: Transform.scale(
        scale: 0.7,
        child: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFFD04959),
          inactiveThumbColor: Colors.black54,
          activeTrackColor: Colors.grey,
          inactiveTrackColor: Colors.grey,
        ),
      ),
    );
  }
}
