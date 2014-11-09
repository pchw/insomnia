debug = require('debug')('insomnia')
{CronJob:Cron} = require 'cron'

TARGET_URL = process.env.TARGET_URL
CRON_INTERVAL = process.env.CRON_INTERVAL

unless TARGET_URL and CRON_INTERVAL
  debug "TARGET_URL or CRON_INTERVAL unspecified."
  debug "TARGET_URL: #{TARGET_URL}"
  debug "CRON_INTERVAL: #{CRON_INTERVAL}"

{CronJob:Cron} = require 'cron'

try
  job  = new Cron 
    cronTime: CRON_INTERVAL
    onTick: ->
      debug "Cron Triggered"
    onComplete: ->
      debug "Cron Finshed"
    start: false
  do job.start

catch e
  debug "Error: #{e}"
  debug "INVALID CRON_INTERVAL! #{CRON_INTERVAL}"
