CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AKIAYSADISSPSXZX3AWE',
    aws_secret_access_key: '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',
    region: 'ap-northeast-1'
  }

  config.fog_directory  = '32naoya25'
  config.cache_storage = :fog
end
