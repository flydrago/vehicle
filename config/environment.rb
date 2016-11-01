# Load the Rails application.
require File.expand_path('../application', __FILE__)
require 'whenever'


module ProductConfig
  DYNAMIC_FIELDS = Hash.new
end

module RestConfig
  PRODUCT_SERVER = ENV["PHOTO_HOST"] || 'http://pic.9kuapp.cn:3001/'

  #CUSTOMER_SERVER = ENV["CUSTOMER_HOST"] || 'http://customer.jiuyunda.net:3000/'
  # CUSTOMER_SERVER = ENV["CUSTOMER_HOST"] || 'http://demo.jiuyunda.net:24798/'
  CUSTOMER_SERVER = ENV["CUSTOMER_HOST"] || 'http://localhost:3001/'


  OA_SERVER = 'http://www.ibuluo.me:9090/'

  #ELEPHANT_HOST = ENV["ELEPHANT_HOST"] || 'http://www.jiuyunda.net:90/'
  ELEPHANT_HOST = ENV["ELEPHANT_HOST"] || 'http://demo.jiuyunda.net:24799/'


  # JXC_HOST = ENV["JXC_HOST"] || 'http://www.jiuyunda.net:98/'
  JXC_HOST = ENV["JXC_HOST"] || 'http://10.99.99.17:3026/'

  # SETTLE_HOST = ENV["SETTLE_HOST"] || 'http://settle.jiukuapp.cn:3000/'
  SETTLE_HOST = ENV["SETTLE_HOST"] || 'http://demo.51xiaoniu.cn:3002/'

  WX_HOST = ENV["WX_HOST"] || 'http://www.ejiuwang.com/'

end

# Initialize the Rails application.
Rails.application.initialize!

