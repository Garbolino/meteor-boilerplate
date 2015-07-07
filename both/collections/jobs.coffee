@QueueJobs = new JobCollection 'queue_jobs'
  # transform: (d) ->
  #  try
  #     res = QueueJobs.createJob d
  #  catch e
  #     res = d
  #  return res

if Meteor.isServer
  QueueJobs.allow
    admin: (userId, method, params) ->
      loggedInUser = Meteor.user()
      if loggedInUser and Roles.userIsInRole(loggedInUser, ['admin', 'staff'])
        true

  @addJob = (jobName, data) ->
    newJob = QueueJobs.createJob(jobName, data)
    newJob.retry({retries: 1, wait: 60*1000})
    newJob.save()
