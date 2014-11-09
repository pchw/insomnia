debug = require('debug')('insomnia')
{CronJob:Cron} = require 'cron'
request = require 'superagent'

TARGET_URL = process.env.TARGET_URL
CRON_INTERVAL = process.env.CRON_INTERVAL

unless TARGET_URL and CRON_INTERVAL
  debug "TARGET_URL or CRON_INTERVAL unspecified."
  debug "TARGET_URL: #{TARGET_URL}"
  debug "CRON_INTERVAL: #{CRON_INTERVAL}"
  return

debug "Env var check succeeded."

try
  job  = new Cron 
    cronTime: CRON_INTERVAL
    onTick: ->
      debug "Cron Triggered"
      request
      .get("#{TARGET_URL}")
      .end (res)->
        debug "Response received. status: #{res.status}"
    onComplete: ->
      debug "Cron Finshed"
    start: false

  debug "Job created."

  do job.start

  debug "Job started."

catch e
  debug "Error: #{e}"
  debug "INVALID CRON_INTERVAL! #{CRON_INTERVAL}"
