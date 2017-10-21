// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:stack_trace/stack_trace.dart';

/// Converts to/from a JSON-structure to a [Trace] object.
class JsonTraceCodec extends Codec<Trace, List<Map<String, Object>>> {
  const JsonTraceCodec();

  @override
  final decoder = const _JsonTraceDecoder();

  @override
  final encoder = const _JsonTraceEncoder();
}

class _JsonTraceDecoder extends Converter<List<Map<String, Object>>, Trace> {
  const _JsonTraceDecoder();

  @override
  Trace convert(List<Map<String, Object>> input) {
    return new Trace(input.map((frame) {
      return new Frame(
        Uri.parse(frame['uri'] as String),
        frame['line'] as int,
        frame['column'] as int,
        frame['member'] as String,
      );
    }));
  }
}

class _JsonTraceEncoder extends Converter<Trace, List<Map<String, Object>>> {
  const _JsonTraceEncoder();

  @override
  List<Map<String, Object>> convert(Trace input) {
    return input.frames.map((frame) {
      return {
        'uri': frame.uri.toString(),
        'line': frame.line,
        'column': frame.column,
        'member': frame.member,
      };
    }).toList();
  }
}
