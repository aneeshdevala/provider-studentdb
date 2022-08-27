
import 'package:database/provider/database_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_screen.dart';

class SearchProfile extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<DatabasePro>(builder: (context, value, child) {
      return ListView.separated(
        itemBuilder: (ctx, index) {
          final data = value.studentList[index];
          if (query == data.name.toLowerCase() ||
              query == data.name.toUpperCase()) {
            return ListTile(
                leading: const Icon(Icons.person),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      (MaterialPageRoute(builder: (ctx) {
                        return ViewScreen(data: data, index: index);
                      })),
                      (route) => false);
                },
                title: Text(data.name.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    )));
          } else {
            return const SizedBox();
          }
        },
        separatorBuilder: (context, value) {
          return const SizedBox(
            height: 0,
            width: 0,
          );
        },
        itemCount: value.studentList.length,
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer<DatabasePro>(builder: (context, value, child) {
      return ListView.separated(
        itemBuilder: (ctx, index) {
          final data = value.studentList[index];
          if (data.name.toLowerCase().contains(query)) {
            return ListTile(
                leading: const Icon(Icons.person),
                onTap: () {
                  Navigator.of(context).push(
                    (MaterialPageRoute(builder: (ctx) {
                      return ViewScreen(data: data, index: index);
                    })),
                  );
                },
                title: Text(data.name.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    )));
          } else {
            return Container();
          }
        },
        separatorBuilder: (context, value) {
          return const SizedBox(
            height: 0,
            width: 0,
          );
        },
        itemCount: value.studentList.length,
      );
    });
  }
}
