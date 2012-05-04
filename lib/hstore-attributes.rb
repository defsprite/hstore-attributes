require "rails"

class HstoreAttributes < Rails::Railtie

  initializer 'hstore-attributes' do
    ActiveSupport.on_load :active_record do
      Rails.logger.info "loading hstore meta columns"
      require "hstore-attributes/activerecord"
    end
  end

end
