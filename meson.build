project('Duplicate', 'vala', 'c', version: '0.2.0')

add_project_arguments(
    ['-DGETTEXT_PACKAGE="' + meson.project_name() + '"',
    '-w'],
    language:'c'
)

executable(
  'duplicate',
  'src/Application.vala',
  'src/Duplicator.vala',
  'src/main.vala',
  dependencies: [
    dependency('gtk+-3.0')
  ],
  install: true
)

subdir('data')

meson.add_install_script('meson/post_install.py')
