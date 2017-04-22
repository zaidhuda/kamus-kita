CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['AWS_ACCESS_KEY'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region:                'ap-southeast-1',
  }
  config.fog_directory  = 'kamus-kita'
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } 
end