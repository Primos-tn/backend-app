#
# File socket_controller.rb
# CopyRights izzY 2016
# Created by hassenfath on 2/12/16
# Updated by
#
class Api::V1::SocketController   < Api::V1::BaseController
  before_action :set_global_vars

  # return where the socket is hosted
  def socket_connection_info
    render :json => {:host => @socket_host}
  end


  private

  # set global vars
  def set_global_vars
    if Rails.env.production?
      @socket_host = "" # FIXME
    else
      @socket_host = ENV['SOCKET_HOST']
    end
  end

end
