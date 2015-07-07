
Meteor.startup ->
  logger.info "Worker Server restarted"
  QueueJobs.startJobServer()


scrapQuoraQuestionWorker = (job, callback) ->
  data = job.data
  logger.debug "scrapQuoraQuestionWorker called", jobType:job.type, jobId:job.doc._id, jobData:data
  try
    job.progress 30, 100
    Meteor.call 'getQuestionInformation', data.questionId
    job.done()
    job.remove()
  catch error
    logger.warn "scrapQuoraQuestionWorker: fail", error:error
    job.fail("#{error}")

  callback null

scrapQuoraQuestionQueue = QueueJobs.processJobs 'scrapQuoraQuestion', { concurrency: 25, pollInterval: 2500 }, scrapQuoraQuestionWorker
