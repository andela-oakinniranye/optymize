module CustomPagination
  extend ActiveSupport::Concern

  module ClassMethods
    # cattr_reader :config_options

    def paginate(page: 1, per_page: 10)
      per_page = per_page
      offset_param = (page * per_page) - per_page
      limit(per_page).offset(offset_param)
    end

    def total_pages
      default_options[:per_page]
    end

    def default_options(*optional)
      optional = optional.first
      per_page = optional.include? :per_page ? optional[:per_page] : 10
      # require 'pry' ; binding.pry
      options = { per_page: per_page }
      # options.merge(args) if args.is_
      optional.each{ |opt|
        options.merge!(opt) if opt.is_a? Hash
      }
      options
    end
  end
end

class ActiveRecord::Base
  #code
  include CustomPagination
end
