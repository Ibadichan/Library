if Rails.env.production? || Rails.env.staging?
  url = URI.parse(ENV['REDISTOGO_URL'] || 'redis://localhost:6379/')
  REDIS = Redis.new url: url
end
