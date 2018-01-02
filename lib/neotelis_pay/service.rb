module NeotelisPay
  class Service

    # 签约申请接口
    # userToken	用户手机号
    # payerName	持卡人姓名
    # certType	证件类型
    # certNo	证件号
    # bankCardType	银行卡类型
    # bankCardNo	银行卡号
    # cvn2	cvn2
    # useTime	有效期
    def self.post_sign_apply(user_token, payer_name, cert_type, cert_no, bank_card_type, bank_card_no, cvn2, use_time, options={})
      service_name = "signApply"
      input_hash = {"type" => service_name,
                    "userToken" => user_token,
                    "payerName" => payer_name,
                    "certType" => cert_type,
                    "certNo" => cert_no,
                    "bankCardType" => bank_card_type,
                    "bankCardNo" => bank_card_no,
                    "cvn2" => cvn2,
                    "useTime" => use_time}
      post_params = NeotelisPay.client_params.merge(options).merge(input_hash)
      #调用查询接口
      msg = NeotelisPay::Util::HttpPost.send_post(service_name, post_params)
      msg
    end

    # 签约确认接口
    # token	授权码
    # verifyCode	短信验证码
    def self.post_sign_confirm(token, verify_code, options={})
      service_name = "signConfirm"
      input_hash = {"type" => service_name,
                    "token" => token,
                    "verifyCode" => verify_code}
      post_params = NeotelisPay.client_params.merge(options).merge(input_hash)
      #调用查询接口
      msg = NeotelisPay::Util::HttpPost.send_post(service_name, post_params)
      msg
    end

    # 签约支付申请接
    # orderId	商户订单号
    # amount	订单金额
    # currency	币种
    # price	商品单价
    # orderTime	订单日期
    # merAcDate	商户会计日期
    # period	订单有效时间
    # busiPartner	商户业务类型
    # merchantAbbr	商户名称
    # productDesc	商品描述
    # productId	商品编号
    # productName	商品名称
    # productNum	商品数量
    # orderDesc	订单描述
    # userToken	用户手机号
    # payerName	持卡人姓名
    # certType	证件类型
    # certNo	证件号
    # bankCardType	银行卡类型
    # bankCardNo	银行卡号
    # bankNo	银行代码
    # cvn2	CVN2
    # cardExpYear	信用卡有效期年
    # cardExpMonth	信用卡有效期月
    # payType	支付类型
    # notifyUrl	后台通知URL
    # bindId	签约协议号
    # reserved1	保留字段1
    # reserved2	保留字段2
    def self.post_prepay(order_id, amount, currency, product_name, bank_no, notify_url, bind_id, options={})
      service_name = "prepay"
      input_hash = {"type" => service_name,
                    "orderId" => order_id,
                    "amount" => amount,
                    "currency" => currency,
                    "orderTime" => Time.now.strftime("%Y%m%d%H%M%S"),
                    "merAcDate" => Time.now.strftime("%Y%m%d"),
                    "merchantAbbr" => NeotelisPay.merchant_abbr,
                    "productName" => NeotelisPay.product_name || product_name,
                    "bankNo" => bank_no,
                    "notifyUrl" => notify_url,
                    "bindId" => bind_id}
      post_params = NeotelisPay.client_params.merge(options).merge(input_hash)
      #调用查询接口
      msg = NeotelisPay::Util::HttpPost.send_post(service_name, post_params)
      msg
    end

    # 签约支付确认接口
    # token	授权码
    # verifyCode	短信验证码
    # orderId	商户订单号
    # amount	订单金额
    def self.post_pay_confirm(token, verify_code, order_id, amount, options={})
      service_name = "payConfirm"
      input_hash = {"type" => service_name,
                    "token" => token,
                    "verifyCode" => verify_code,
                    "orderId" => order_id,
                    "amount" => amount}
      post_params = NeotelisPay.client_params.merge(options).merge(input_hash)
      #调用查询接口
      msg = NeotelisPay::Util::HttpPost.send_post(service_name, post_params)
      msg
    end

    # 网关支付接口
    # bankNo	银行编码
    # orderId	商户订单号
    # amount	订单金额
    # currency	币种
    # orderTime	订单日期
    # productDesc	商品描述
    # productId	商品编号
    # productName	商品名称
    # productNum	商品数量
    # notifyUrl	后台通知URL
    # callbackUrl	前台地址
    # reserved1	保留字段1
    # reserved2	保留字段2
    def self.post_gateway_pay(order_id, amount, currency, product_name, bank_no, notify_url, options={})
      service_name = "gatewayPay"
      input_hash = {"type" => service_name,
                    "bankNo" => bank_no,
                    "orderId" => order_id,
                    "amount" => amount,
                    "currency" => currency,
                    "orderTime" => Time.now.strftime("%Y%m%d%H%M%S"),
                    "merAcDate" => Time.now.strftime("%Y%m%d"),
                    "merchantAbbr" => NeotelisPay.merchant_abbr,
                    "productName" => NeotelisPay.product_name || product_name,
                    "notifyUrl" => notify_url}
      post_params = NeotelisPay.client_params.merge(options).merge(input_hash)
      #调用查询接口
      msg = NeotelisPay::Util::HttpPost.send_post(service_name, post_params)
      msg
    end

  end
end