project('com.paysonwallach.duplicate', 'vala', 'c', version: '0.3.0')

i18n = import('i18n')

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

# contractor
subdir('data')

# gettext translations
subdir('po')

meson.add_install_script('meson/post_install.py')
