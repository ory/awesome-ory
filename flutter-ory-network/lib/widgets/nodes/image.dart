// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ory_client/ory_client.dart';

class ImageNode extends StatelessWidget {
  final UiNode node;

  const ImageNode({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    final imageNode = node.attributes.oneOf.value as UiNodeImageAttributes;
    // convert base64 string to bytes
    Uint8List bytes = base64.decode(imageNode.src.split(',').last);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Center(
        child: SizedBox(
            width: imageNode.width.toDouble(),
            height: imageNode.height.toDouble(),
            child: Image.memory(bytes)),
      ),
    );
  }
}
