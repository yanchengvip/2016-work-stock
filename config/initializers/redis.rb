config = YAML::load(File.read(File.join(Rails.root.to_s, 'config/redis.yml')))[Rails.env.to_s]
$redis = Redis.new(config['redis'])

Redis::Objects.redis = $redis
