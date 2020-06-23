import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final bool searchMode;
  final Function(String) onChanged;
  final GlobalKey<FormState> formKey;
  final GestureTapCallback onToggleSearchMode;

  SearchBar({
    this.formKey,
    this.onChanged,
    this.searchMode,
    this.onToggleSearchMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final inputTextStyle =
        theme.textTheme.headline5.copyWith(color: Colors.white);
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 2,
            offset: Offset(0, 0),
            color: theme.primaryColorLight,
          )
        ],
      ),
      constraints: BoxConstraints(maxHeight: 70),
      height: searchMode ? size.height * 0.1 : 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          searchMode
              ? Flexible(
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      cursorWidth: 4,
                      autofocus: true,
                      onChanged: onChanged,
                      style: inputTextStyle,
                      cursorColor: Colors.white,
                      textCapitalization: TextCapitalization.words,
                      validator: (v) {
                        if (v.isEmpty) return 'Title cannot be empty.';
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: inputTextStyle,
                        hintText: 'Search Pokemon',
                        labelStyle: inputTextStyle,
                        contentPadding: EdgeInsets.only(left: 20, right: 10),
                      ),
                    ),
                  ),
                )
              : Spacer(),
          IconButton(
            onPressed: onToggleSearchMode,
            icon: Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
