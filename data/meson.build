config_data = configuration_data()
config_data.set('install_prefix', get_option('prefix'))
config_data.set('bin_dir', get_option('bindir'))
config_data.set('exec_name', meson.project_name())

contract_in = configure_file(
    input: meson.project_name() + '.contract.in.in',
    output: meson.project_name() + '.contract.in',
    configuration: config_data,
    install: false,
)

po_dir = join_paths(meson.source_root(), 'po')

i18n.merge_file(
    'contract',
    input: contract_in,
    output: meson.project_name() + '.contract',
    install: true,
    install_dir: join_paths(get_option('datadir'), 'contractor'),
    po_dir: join_paths(meson.source_root(), 'po', 'extra'),
    type: 'desktop'
)
