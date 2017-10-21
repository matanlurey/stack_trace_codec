# stack_trace_codec

<p align="center">
  <a href="https://travis-ci.org/matanlurey/stack_trace_codec">
    <img src="https://travis-ci.org/matanlurey/stack_trace_codec.svg?branch=master" alt="Build Status" />
  </a>
  <a href="https://pub.dartlang.org/packages/stack_trace_codec">
    <img src="https://img.shields.io/pub/v/stack_trace_codec.svg" alt="Pub Package Version" />
  </a>
  <a href="https://www.dartdocs.org/documentation/stack_trace_codec/latest">
    <img src="https://img.shields.io/badge/dartdocs-latest-blue.svg" alt="Latest Dartdocs" />
  </a>
</p>

Serialize stack traces from the [`stack_trace`][] package.

[`stack_trace`]: https://pub.dartlang.org/stack_trace

* [Installation](#installation)
* [Usage](#usage)
* [Contributing](#contributing)
  * [Testing](#testing)

## Installation

Add `stack_trace_codec` in your [`pubspec.yaml`][pubspec] file:

```yaml
dependencies:
  stack_trace_codec: ^0.1.0
```

And that's it! See [usage](#usage) for details.

## Usage

Currently, a single codec, `JsonTraceCodec`, is available:

```dart
import 'dart:convert';

import 'package:stack_trace/stack_trace.dart';
import 'package:stack_trace_codec/stack_trace_codec.dart';

void logJson(String json) { /* ... */ }

// See package:stack_trace for details on converting from StackTrace --> Trace.
void logStackTrace(Trace trace) {
  logJson(JSON.encode(const JsonTraceCodec().encode(trace)));
}
```

## Contributing

We welcome a diverse set of contributions, including, but not limited to:

* [Filing bugs and feature requests][file_an_issue]
* [Send a pull request][pull_request]
* Or, create something awesome using this API and share with us and others!

For the stability of the API and existing users, consider opening an issue
first before implementing a large new feature or breaking an API. For smaller
changes (like documentation, minor bug fixes), just send a pull request.

### Testing

All pull requests are validated against [travis][travis], and must pass.

Ensure code passes all our [analyzer checks][analysis_options]:

```sh
$ dartanalyzer .
```

Ensure all code is formatted with the latest [dev-channel SDK][dev_sdk].

```sh
$ dartfmt -w .
```

Run all of our unit tests:

```sh
$ pub run test
```

[analysis_options]: analysis_options.yaml
[travis]: https://travis-ci.org/
[dev_sdk]: https://www.dartlang.org/install]
[file_an_issue]: https://github.com/matanlurey/stack_trace_codec/issues/new
[pull_request]: https://github.com/matanlurey/stack_trace_codec/pulls