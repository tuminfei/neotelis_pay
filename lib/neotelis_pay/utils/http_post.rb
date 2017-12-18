require 'logger'
require 'des'

module NeotelisPay
  module Utils
    class HttpPost

      DEFAULT_ERR_MSG = '{"returnCode":"E88888","message":"其他错误！"}'

      #对参数就行加密
      def self.get_des_params(service_type, params)
        des_key_list = NeotelisPay::Utils::Des.des_param_list(service_type)
        des_key_list.each do |key|
          if params.keys.include?(key)
            params[key] = NeotelisPay::Utils::Des.decode(params[key], NeotelisPay.secret_key)
          end
        end
        return params
      end

      #生成md5签名
      def self.get_sign_data(params)
        #排序
        data_hash = sorted_hash(params)
        #拼接
        data_arr = []
        data_hash.each do |k,v|
          data_arr << v.to_s
        end
        data_str = data_arr.join('')
        #MD5摘要
        data_md5 =  NeotelisPay::Utils::Crypt.crypt_md5(data_str, NeotelisPay.secret_key)
        return data_str, data_md5
      end

      #排序
      def self.sorted_hash(in_hash)
        return in_hash.sort{|a,b| a.to_s <=> b.to_s  }
      end

      #发送请求
      def self.send_post(service_type, query_params)
        api_url = ''

        api_url = NeotelisPay.api_base_url
        #对参数就行加密
        des_params = get_des_params(service_type, query_params)
        #对参数就行排序并签名
        sign_value, sign_data = get_sign_data(des_params)

        #加签名的查询参数
        func_params = {"transData" => des_params.to_json, "signData" => sign_data}
        func_all_params = func_params.merge(NeotelisPay.client_options)
        conn = Faraday.new(:url => api_url)

        response = conn.post '', func_all_params
        html_response = response.body

        if NeotelisPay.debug_mode
          log_file = File.join(Rails.root, "log", "neotelis_pay.log")
          logger = Logger.new(log_file)
          logger.info('--------------SUNING PAY DEBUG--------------')
          logger.info("URL:#{api_url.to_s}")
          logger.info("PARAMS:#{func_all_params.to_s}")
          logger.info("RESPONSE:#{html_response.force_encoding('UTF-8')}")
        end

        begin
          msg = JSON.parse(html_response)
        rescue JSON::ParserError => e
          msg = JSON.parse(DEFAULT_ERR_MSG)
        end
        msg
      end
    end
  end
end
