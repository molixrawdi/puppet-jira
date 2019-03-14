# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include jira::installjira
class jira::installjira{
file{'/vagrant/response.varfile':
ensure => 'present',
source => 'puppet:///modules/jira/response.varfiles',
}
file{'/vagrant/JiraInstaller.sh':
ensure => 'present',
source => 'puppet:///modules/jira/JiraInstaller.sh',
}
file{'/opt/atlassian':
ensure =>'directory',
}
file{'/opt/atlassian/jira':
ensure => 'directory',
}
file{'/opt/atlassian/jira-home':
ensure => 'directory',
}
file{'/opt/atlassian/jira/lib':
ensure => 'directory',
}
exec{'install_jira from binary':
cwd =>'/vagrant',
command => " bash -c /vagrant/atlassian-jira-software-8.0.2-x64.bin -q -varfile /vagrant/response.varfile",
#command => "bash -c /vagrant/JiraInstaller.sh",
path => ['/usr/bin','/usr/sbin','/bin'],
provider => shell,
unless => ['test -d /opt/atlassian'],
before => Class['jira::jirafiles'],
}
}
