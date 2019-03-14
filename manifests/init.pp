# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include jira
class jira {
 class{jira::jirauser:}
 class{jira::installjira:}
 class{jira::jirafiles:}
}
