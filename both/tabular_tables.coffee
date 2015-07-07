TabularTables = {}
Meteor.isClient and Template.registerHelper('TabularTables', TabularTables)


TabularTables.JobsAdmin = new Tabular.Table
  name: 'JobsAdmin'
  collection: QueueJobs
  pub: "tabular_Jobs",
  # allow:  (userId) ->
  #   return Roles.userIsInRole userId, 'admin'
  pageLength: 25
  extraFields: ['retries', "depends", 'resolved', 'repeated', 'repeats',
                'status', 'progress', 'log'
  ]
  autoWidth: false
  order: [[3, "desc"]],
  columns: [
    {
      title: "Type"
      data: "type"
    }
    {
      title: "ID"
      data: "_id"
    }
    {
      title: "UserId"
      data: "data.userId"
    }
    {
      title: "Run at"
      data: "after"
      render: (val, type, doc) ->
        output = moment(val).fromNow()
        if val > new Date()
          "<span class='text-danger'>#{output}</span>"
        else
          "<span class='text-success'>#{output}</span>"

    }
    {
      title: "Updated"
      data: "updated"
      render: (val, type, doc) ->
        moment(val).fromNow()
    }
    {
      title: "Priority"
      data: "priority"
    }
    {
      title: "Dep"
      # data: "depends"
      render: (val, type, doc) ->
        numDepends = doc.depends?.length or 0
        numResolved = doc.resolved?.length or 0
        "#{numDepends} / #{numResolved}"
    }
    {
      title: "Attempts"
      data: "retried"
      render: (val, type, doc) ->
        numRetries = if doc.retries is QueueJobs.Forever then "∞" else doc.retries
        "#{doc.retried} / #{numRetries}"
    }
    {
      title: "Repeats"
      data: "repeated"
      render: (val, type, doc) ->
        numRepeats = if doc.repeats is QueueJobs.Forever then "∞" else doc.repeats
        "#{doc.repeated} / #{numRepeats}"
    }
    {
      title: "Status"
      data: "status"
      tmpl: Meteor.isClient && Template.tabularJobStatus
    }
    {
      title: "Actions"
      tmpl: Meteor.isClient && Template.tabularJobActions
    }


  ]
