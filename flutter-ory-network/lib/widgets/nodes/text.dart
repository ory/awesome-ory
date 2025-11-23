// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:ory_client/ory_client.dart';

class TextNode extends StatelessWidget {
  final UiNode node;

  const TextNode({super.key, required this.node});
  @override
  Widget build(BuildContext context) {
    final attributes = node.attributes.oneOf.value as UiNodeTextAttributes;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          // show label test if it is available
          if (node.meta.label?.text != null) Text(node.meta.label!.text),
          const SizedBox(
            height: 10,
          ),
          Text(attributes.text.text),
        ],
      ),
    );
  }
}
