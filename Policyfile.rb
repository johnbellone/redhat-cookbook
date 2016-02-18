name 'redhat'
run_list 'redhat::default'
default_source :community
cookbook 'redhat', path: '.'
