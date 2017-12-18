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
      input_hash = {"type" => "signApply",
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
      msg = NeotelisPay::Util::HttpPost.send_post('signApply', post_params)
      msg
    end
  end
end