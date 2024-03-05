import 'package:age_care/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/constants/app_colors.dart';
import '../../config/constants/text_strings.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  TextEditingController textFieldController = TextEditingController();
  List<Note> notes = [];
  late Future<SharedPreferences> _preferences;
  @override
  void initState() {
    _preferences = SharedPreferences.getInstance();
    _loadNotes();
    super.initState();
  }

  Future<void> _loadNotes() async {
    final SharedPreferences preferences = await _preferences;
    List<String>? savedNotes = preferences.getStringList('notes');
    if (savedNotes != null) {
      setState(() {
        notes = savedNotes.map((noteText) => Note(noteText)).toList();
      });
    }
  }

  Future<void> _saveNotes() async {
    final SharedPreferences preferences = await _preferences;
    List<String> noteTexts = notes.map((note) => note.text).toList();
    await preferences.setStringList('notes', noteTexts);
  }

  void addNote(String newText) {
    setState(() {
      notes.add(Note(newText));
      _saveNotes();
    });
    Navigator.pop(context);
  }

  void deleteNote(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete confirmation"),
            actions: [
              TextButton(
                child: const Text("Delete"),
                onPressed: () {
                  setState(() {
                    notes.removeAt(index);
                    _saveNotes();
                  });
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void editNote(int index) {
    String initialText = notes[index].text;
    TextEditingController editFieldController =
        TextEditingController(text: initialText);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Note"),
          content: TextFormField(
            maxLines: 3,
            controller: editFieldController,
            decoration: const InputDecoration(hintText: "Edit your note"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                setState(() {
                  notes[index].text = editFieldController.text;
                  _saveNotes();
                });
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showAddNoteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add a Note"),
          content: TextFormField(
            controller: textFieldController,
            decoration: const InputDecoration(hintText: "Enter your note"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                addNote(textFieldController.text);
                textFieldController.clear();
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.dark : AppColors.whiteText,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: isDarkMode ? AppColors.dark : AppColors.primaryColor,
        title: Text(
          'Notes'.toUpperCase(),
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
        leading: IconButton(
          color: AppColors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDarkMode ? AppColors.dark : AppColors.primaryColor,
        onPressed: showAddNoteDialog,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      body: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return Dismissible(
              secondaryBackground: Container(
                color: const Color.fromARGB(255, 14, 57, 93),
                alignment: Alignment.centerLeft,
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              key: Key(notes[index].text),
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.primaryColor,
                    border: Border.all(
                      color: AppColors.lightGrey,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(notes[index].text,
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            letterSpacing: 1,
                            color: Colors.white,
                            fontWeight: FontWeight.w400)),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Iconsax.edit, color: Colors.white),
                          onPressed: () {
                            editNote(index);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.white),
                          onPressed: () {
                            deleteNote(index);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class Note {
  String text;

  Note(this.text);
}
