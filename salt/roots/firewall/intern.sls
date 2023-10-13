#!py

def run():
    config = {}

    # Install packages, no magic here
    config['firewallpackagelist'] = {
                'pkg.installed': [
                    {'name': 'iptables-persistent'},
                ],
                'service.running': [
                    {'name': 'netfilter-persistent'},
                    {'enable': 'True'}
                ]
    }

    # get hostname for targeting firewall
    hostname = __grains__['host']
    if 'router' in hostname:
        fireports = __pillar__['router']['firewall']
    elif 'web' in hostname:
        fireports = __pillar__['webserver']['firewall']
    else:
        fireports = False
    
    # get all the interfaces and strip off lo
    int4 = __grains__['ip4_interfaces']
    del int4['lo']

    mgmt = ''
    appserver = False
    for intname, ip in int4.items():
        if ip == ['10.0.2.15',]:
            mgmt = intname

    if mgmt != '':
        del int4[mgmt]

    if len(int4) == 1:
        appserver = True

    # This is the rules file
    config['rulefilev4'] = {
            'file.managed': [
                {'name': '/etc/iptables/rules.v4'},
                {'source': 'salt://firewall/rules.v4.intern.jinja'},
                {'user': 'root'},
                {'group': 'root'},
                {'mode': '600'},
                {'template': 'jinja'},
                {'makedirs': 'True'},
                {'context': {
                    'mgmt': mgmt,
                    'intint': int4.keys(),
                    'appserver': appserver,
                    'fireports': fireports
                    }
                }
                ]
    }

    return config
