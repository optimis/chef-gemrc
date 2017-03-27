name 'default'
default_source :community
default_source :chef_repo, '..'
cookbook 'gemrc', path: '../../..'
run_list 'gemrc::default', 'test::default'
named_run_list :centos, 'sudo::default', 'yum::default', 'yum-epel::default', run_list
named_run_list :debian, 'sudo::default', 'apt::default', run_list
named_run_list :freebsd, 'freebsd::default', run_list
named_run_list :windows, 'windows::default', run_list
