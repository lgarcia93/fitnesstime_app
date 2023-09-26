import 'package:fitness_time/src/ui/widgets/default_loader/default_loader.dart';
import 'package:fitness_time/src/ui/widgets/error_message/error_message.dart';
import 'package:flutter/material.dart';

class CustomListView<T> extends StatefulWidget {
  final List<T> content;
  final IndexedWidgetBuilder itemBuilder;
  final VoidCallback onEndOfScroll;
  final String errorMessage;
  final VoidCallback onTryAgain;
  final Widget emptyPlaceholder;
  final IndexedWidgetBuilder separatorBuilder;
  final bool errorState;
  final bool isLoading;
  final VoidCallback onPullToRefresh;

  CustomListView({
    this.content,
    this.itemBuilder,
    this.onEndOfScroll,
    this.errorMessage = '',
    this.onTryAgain,
    this.separatorBuilder,
    this.emptyPlaceholder,
    this.onPullToRefresh,
    this.errorState = false,
    this.isLoading = false,
  })  : assert(content != null),
        assert(itemBuilder != null);

  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
        } else {
          widget.onEndOfScroll?.call();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.errorState) {
      return ErrorMessage(
        message: widget.errorMessage,
        onTryAgain: widget.onTryAgain,
      );
    }

    if (widget.content?.isEmpty ?? true) {
      return widget.emptyPlaceholder;
    }

    if (widget.isLoading) {
      return Center(
        child: DefaultLoader(),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        widget.onPullToRefresh?.call();
      },
      child: ListView.separated(
        separatorBuilder: widget.separatorBuilder ??
            (_, __) => SizedBox(
                  height: 0,
                ),
        itemBuilder: widget.itemBuilder,
        itemCount: widget.content.length,
        controller: scrollController,
      ),
    );
  }
}
