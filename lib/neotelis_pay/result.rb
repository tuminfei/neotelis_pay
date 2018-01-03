module NeotelisPay
  class Result
    attr_accessor :raw, :msg

    RESULT_SUCCESS_FLAG = '000000'

    # 1-快捷支付；
    # 2-代扣；
    # 3-代付；
    # 6-认证支付；
    # 10-微信扫码；
    # 20-支付宝扫码；
    # 11-微信h5支付；
    # 30-QQ钱包扫码；
    # 50-京东扫码；
    ORDER_TYPE_KJ = 1
    ORDER_TYPE_DK = 2
    ORDER_TYPE_DF = 3
    ORDER_TYPE_RZZF = 6
    ORDER_TYPE_WXSM = 10
    ORDER_TYPE_ZFBSM = 20
    ORDER_TYPE_WXH5 = 11
    ORDER_TYPE_QQSM = 30
    ORDER_TYPE_JDSM = 50

    def initialize(result)
      self.raw = result
      self.msg = JSON.parse(result)
    end

    def success?
      @msg['returnCode'] == RESULT_SUCCESS_FLAG
    end
  end
end