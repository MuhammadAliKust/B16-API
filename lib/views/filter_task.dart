import 'package:b16_api/models/task.dart';
import 'package:b16_api/providers/token.dart';
import 'package:b16_api/services/task.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FilterTaskView extends StatefulWidget {
  const FilterTaskView({super.key});

  @override
  State<FilterTaskView> createState() => _FilterTaskViewState();
}

class _FilterTaskViewState extends State<FilterTaskView> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  List<Task> taskList = [];
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Search Task")),
      body: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text("First: ${DateFormat.yMMMMd().format(firstDate)}"),
                  ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      ).then((val) {
                        firstDate = val!;
                        setState(() {});
                      });
                    },
                    child: Text("Select First Date"),
                  ),
                ],
              ),

              Column(
                children: [
                  Text("Last: ${DateFormat.yMMMMd().format(lastDate)}"),
                  ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now().add(Duration(days: 30)),
                      ).then((val) {
                        lastDate = val!;
                        setState(() {});
                      });
                    },
                    child: Text("Select Last Date"),
                  ),
                ],
              ),
            ],
          ),

          ElevatedButton(
            onPressed: () async {
              try {
                isLoading = true;
                setState(() {});
                await TaskServices()
                    .filterTask(
                      token: tokenProvider.getToken(),
                      firstDate: firstDate.toString(),
                      lastDate: lastDate.toString(),
                    )
                    .then((val) {
                      isLoading = false;
                      taskList = val.tasks!;
                      setState(() {});
                    });
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
            child: Text("Filter Task"),
          ),
          if (isLoading)
            Center(child: CircularProgressIndicator())
          else
            Expanded(
              child: ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    leading: Icon(Icons.task),
                    title: Text(taskList[i].description.toString()),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
