require "neotelis_pay/version"

module NeotelisPay
  @client_params = {}
  @client_options = {}
  @debug_mode = true
  @version = '1.0.0'
  @input_charset = 'UTF-8'
  @sign_type = 'MD5'
  @dev = 'ruby'
  @request_id = ''

  #签约申请接口
  SERVICE_TYPE_SIGN_APPLY = 'signApply'
  #签约确认接口
  SERVICE_TYPE_SIGN_CONFIRM = 'signConfirm'
  #签约支付申请接口
  SERVICE_TYPE_PREPAY = 'prepay'
  #签约支付确认接口
  SERVICE_TYPE_PAY_CONFIRM = 'payConfirm'

  class<< self
    attr_accessor :merchant_id, :request_ip, :secret_key, :debug_mode
    attr_reader :api_base_url

    def api_base_url=(url)
      @api_base_url = url
    end

    def client_params
      uuid = UUID.new
      @request_id = uuid.generate
      params = {"merchantId" => @merchant_id,
                "requestId" => @request_id,
                "requestTime" => Time.now.strftime("%Y%m%d%H%M%S"),
                "requestIp" => @request_ip}
      @client_params = params
      @client_params
    end

    def client_options
      options = {"signType" => @sign_type, "version" => @version, "dev" => @dev}
      @client_options = options
      @client_options
    end

    def debug_mode?
      @debug_mode
    end
  end
end
