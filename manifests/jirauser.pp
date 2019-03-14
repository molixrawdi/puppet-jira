# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include jira::jirauser
class jira::jirauser {

  group { 'jira':
    ensure => 'present',
    gid => '600',
  }

  user { 'jira':
    ensure => 'present',
    gid => '600',
    uid => '600',
    home => '/home/jira',
    comment => 'This is the Jira user',
    shell => '/bin/bash',
  }
}
