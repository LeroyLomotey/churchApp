import 'dart:io';

import 'package:church_app/services/editor_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

import '../../services/app_data.dart';

class BlogEditorPage extends StatefulWidget {
  final QuillController controller;
  static final titleController = TextEditingController();
  static File _imagePicked = File('null');
  const BlogEditorPage({super.key, required this.controller});

  static title() {
    return titleController.text;
  }

  static imagePicked() {
    return _imagePicked;
  }

  @override
  State<BlogEditorPage> createState() => _BlogEditorPageState();
}

class _BlogEditorPageState extends State<BlogEditorPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final data = context.read<AppData>();
    final FocusNode bodyNode = FocusNode();

    bodyNode.addListener(() {
      if (!bodyNode.hasFocus) {
        FocusScope.of(context).unfocus();
      }
    });
    return SingleChildScrollView(
      child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              SizedBox(
                height: 60,
                //-----------------------------TItle input
                child: TextField(
                  autofocus: false,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: 'Title',
                      hintStyle: TextStyle(color: Colors.black54)),
                  style: const TextStyle(color: Colors.black),
                  controller: BlogEditorPage.titleController,
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Stack(
                  children: [
                    !BlogEditorPage._imagePicked.existsSync()
                        ? Image.asset(
                            'assets/images/logo.png',
                            width: 100,
                            height: 100,
                          )
                        : Image.file(
                            BlogEditorPage._imagePicked,
                            width: 100,
                            height: 100,
                          ),
                    Center(
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.white54)),
                          onPressed: () async {
                            final temp = await data.addImage(context);
                            setState(() {
                              BlogEditorPage._imagePicked = temp;
                            });
                          },
                          child: const Icon(color: Colors.black, Icons.add)),
                    ),
                  ],
                ),
              ),
              FocusScope(
                  onFocusChange: (hasFocus) {
                    if (!hasFocus) {
                      bodyNode.unfocus();
                    }
                  },
                  child: SizedBox(
                    height: size.height - 160,
                    child: Theme(
                      data: EditorThemeClass.darkTheme,
                      child: Column(
                        children: [
                          QuillToolbar.basic(
                              color: Colors.black,
                              controller: widget.controller),
                          Expanded(
                            child: QuillEditor(
                              customStyles: DefaultStyles(color: Colors.black),
                              scrollController: ScrollController(),
                              padding: const EdgeInsets.all(10),
                              enableUnfocusOnTapOutside: true,
                              controller: widget.controller,
                              maxContentWidth: size.width,
                              paintCursorAboveText: true,
                              focusNode: bodyNode,
                              showCursor: true,
                              scrollable: true,
                              autoFocus: false,
                              readOnly: false,
                              expands: false,
                              // true for view only mode
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}
