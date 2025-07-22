// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bd_mtur/core/app_screens.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/core/core.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final _notesController = TextEditingController();
  List _notesList = [];

  @override
  void initState() {
    super.initState();

    _readData().then((data) {
      setState(() {
        _notesList = json.decode(data);
      });
    });
  }

  // String _addNote(note) {
  //   setState(() {
  //     Map<String, dynamic> newNote = {};
  //     newNote["text"] = _notesController.text;
  //     _notesController.text = "";
  //     newNote["ok"] = false;
  //     if (newNote["text"] == null || newNote["text"].isEmpty) {
  //       errorNote();
  //     } else {
  //       _notesList.add(newNote);
  //       _saveData();
  //     }
  //   });
  // }

  void _delete() {
    setState(() {
      _notesList.clear();
      _saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '';
                }
                return null;
              },
              controller: _notesController,
              onFieldSubmitted: (String note) {
                // _addNote(note);
              },
              decoration: InputDecoration(
                labelText:
                    "Use este espaço para fazer anotações que considere necessárias sobre o recurso.",
                labelStyle: AppTextStyles.bodyGrey,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.white,
                    width: 0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.white, width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffE3E5E5),
                    width: 0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.white, width: 0),
                ),
                errorStyle: TextStyle(height: 0),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                floatingLabelStyle:
                    TextStyle(fontSize: 0, color: AppColors.white),
              ),
              style: AppTextStyles.bodyGrey,
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          //   child: ListView.builder(
          //       shrinkWrap: true,
          //       itemCount: _notesList.length,
          //       itemBuilder: (context, index) {
          //         return ListTile(
          //             title: Text(
          //           "${_notesList[index]['text']}" ?? 'Nota $index',
          //           style: AppTextStyles.labelContentText,
          //         ));
          //       }),
          // ),
        ],
      ),
    );
  }

  Future<bool> errorNote() async {
    return PopUpMessage(context, "Erro Anotação",
            "Nenhum conteúdo foi inserido na anotação.") ??
        false;
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_notesList);

    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();

      return file.readAsString();
    } catch (e) {
      return 'Erro';
    }
  }
}
