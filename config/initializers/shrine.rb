# frozen_string_literal: true

require 'cloudinary'
require 'shrine/storage/cloudinary'
Cloudinary.config(
  cloud_name: 'numair-majid123',
  api_key: '316945685729473',
  api_secret: 'Si26VqoPK2M9ChC6iGl1nhcU8b8'
)
Shrine.storages = {
  cache: Shrine::Storage::Cloudinary.new(prefix: 'DinnerDash/cache'), # for direct uploads
  store: Shrine::Storage::Cloudinary.new(prefix: 'DinnerDash')
}
Shrine.plugin :activerecord           # loads Active Record integration
Shrine.plugin :cached_attachment_data # enables retaining cached file across form redisplays
Shrine.plugin :restore_cached_data    # extracts metadata for assigned cached files
Shrine.plugin :validation_helpers
Shrine.plugin :validation
