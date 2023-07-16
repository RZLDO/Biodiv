import 'package:biodiv/BloC/class/class_bloc.dart';
import 'package:biodiv/BloC/ordo/ordo_bloc.dart';
import 'package:biodiv/repository/class_repository.dart';
import 'package:biodiv/repository/ordo_repository.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';

class TaxonomiScreen extends StatefulWidget {
  const TaxonomiScreen({
    super.key,
  });

  @override
  State<TaxonomiScreen> createState() => _TaxonomiScreenState();
}

class _TaxonomiScreenState extends State<TaxonomiScreen> {
  late ClassBloc _classBloc;
  // ignore: unused_field
  late OrdoBloc _ordoBloc;
  final List<MyNode> _nodeList = [MyNode(title: "class", children: [])];
  @override
  void initState() {
    super.initState();
    _classBloc = ClassBloc(repository: ClassRepository());
    _ordoBloc = OrdoBloc(repository: OrdoRepository());
    _classBloc.add(GetDataClassEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => _classBloc,
          child: BlocBuilder(
              bloc: _classBloc,
              builder: (context, state) {
                if (state is GetDataSuccess) {
                  List<MyNode> newChildren = state.dataClass
                      .map((item) => MyNode(title: item.namaLatin))
                      .toList();
                  _nodeList[0].children = newChildren;
                  return MyTreeView(
                    nodes: _nodeList,
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.mainColor,
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}

class MyNode {
  MyNode({
    required this.title,
    this.children = const <MyNode>[],
  });

  final String title;
  List<MyNode> children;
}

class MyTreeView extends StatefulWidget {
  final List<MyNode> nodes;

  const MyTreeView({Key? key, required this.nodes}) : super(key: key);

  @override
  State<MyTreeView> createState() => _MyTreeViewState();
}

class _MyTreeViewState extends State<MyTreeView> {
  late final TreeController<MyNode> treeController;

  @override
  void initState() {
    super.initState();
    treeController = TreeController<MyNode>(
      roots: widget.nodes,
      childrenProvider: (MyNode node) => node.children,
    );
  }

  @override
  void dispose() {
    treeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TreeView<MyNode>(
      treeController: treeController,
      nodeBuilder: (BuildContext context, TreeEntry<MyNode> entry) {
        return MyTreeTile(
          key: ValueKey(entry.node),
          entry: entry,
          onTap: () => treeController.toggleExpansion(entry.node),
        );
      },
    );
  }
}

class MyTreeTile extends StatelessWidget {
  const MyTreeTile({
    Key? key,
    required this.entry,
    required this.onTap,
  }) : super(key: key);

  final TreeEntry<MyNode> entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: TreeIndentation(
        entry: entry,
        guide: const IndentGuide.connectingLines(indent: 48),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
          child: Row(
            children: [
              FolderButton(
                isOpen: entry.hasChildren ? entry.isExpanded : null,
                onPressed: entry.hasChildren ? onTap : null,
              ),
              Text(entry.node.title),
            ],
          ),
        ),
      ),
    );
  }
}
