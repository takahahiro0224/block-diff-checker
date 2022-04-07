require 'slack/incoming/webhooks'

class SlackNotifier
  def post(message)
    slack = Slack::Incoming::Webhooks.new ENV['SLACK_WEBHOOK_URL'], username: 'block-diff-checker'
    slack.post message
  end
end
