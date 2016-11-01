require 'rubygems'
require 'rufus-scheduler'
require 'net/http'


def exec_scheduler

end

begin
  exec_scheduler
rescue Exception => e
  Rails.logger.info "执行task调度异常，信息为：#{e.message}"
end