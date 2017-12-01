task send_daily_digest: :environment do
  DailyDigestJob.perform_now
end
