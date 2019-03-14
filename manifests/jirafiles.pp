# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include jira::jirafiles
class jira::jirafiles {

file{ "/opt/atlassian/jira/lib/mysql-connector-java-5.1.47-bin.jar":
ensure => 'present',
source => 'puppet:///jira/mysql-connector-java-5.1.47-bin.jar',
}
file{ "/opt/atlassian/jira/lib/mysql-connector-java-5.1.47.jar":
ensure => 'present',
source => 'puppet:///jira/mysql-connector-java-5.1.47.jar',
}
file{"/var/atlassian/application-data/jira/dbconfig.xml":
ensure => 'present',
content => epp('jira/dbconfig.xml.epp'),
}
file{'/lib/systemd/system/jira.service':
ensure => 'present',
source => 'puppet:///jira/jira.service',
}
