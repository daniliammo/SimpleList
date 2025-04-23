example_deps = [
  lib_dependency,
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
]

example_sources = files(
  'main.vala',
)

executable(
  'example',

  example_sources,
  vala_args: ['--target-glib=2.58'],
  dependencies: example_deps,
  link_args: [],
  install: false,
)
