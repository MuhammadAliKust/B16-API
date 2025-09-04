import 'package:b16_api/models/task.dart';
import 'package:b16_api/providers/token.dart';
import 'package:b16_api/services/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchTaskView extends StatefulWidget {
  const SearchTaskView({super.key});

  @override
  State<SearchTaskView> createState() => _SearchTaskViewState();
}

class _SearchTaskViewState extends State<SearchTaskView> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  List<Task> taskList = [];

  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Search Task")),
      body: Column(
        children: [
          TextField(controller: searchController),
          ElevatedButton(
            onPressed: () async {
              try {
                isLoading = true;
                setState(() {});
                await TaskServices()
                    .searchTask(
                      token: tokenProvider.getToken(),
                      searchKeyword: searchController.text,
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
            child: Text("Search Task"),
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
