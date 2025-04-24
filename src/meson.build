simplelist_sources = [
  'SimpleList.vala',
  'LazyCompactingList.vala',
  'ActiveCompactingList.vala',
]

simplelist_deps = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
]

c_compiler_arguments = ['-DG_DISABLE_CHECKS']
add_project_arguments(c_compiler_arguments, language: 'c')

c_linker_arguments = ['-Ofast']
add_project_link_arguments(c_linker_arguments, language: 'c')

# Нужно обязательно название в lowercase. если не lowercase то линкер может запутаться.
lib = library(
  'simplelist',

  simplelist_sources,
  dependencies: simplelist_deps,
  install: true,
  install_dir: [true, true, true],
)

pkg.generate(
  name: 'simplelist',
  description: 'SimpleList library',

  libraries: lib,
  version: meson.project_version(),
  subdirs: 'simplelist',
  filebase: 'simplelist',
  requires: ['glib-2.0', 'gobject-2.0'],
)

lib_dependency = declare_dependency(link_with: lib, include_directories: include_directories('.'))
