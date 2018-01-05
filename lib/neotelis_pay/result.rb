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

    # 网关支付-银行编码
    BANK_CODE_MAP = {
        'CCB' => '建设银行',
        'HXB' => '华夏银行',
        'CEB'	=> '光大银行',
        'BOC'	=> '中国银行',
        'HEBB' => '河北银行',
        'CIB'	=> '兴业银行',
        'QDCB' =>'青岛银行',
        'BEAI' => '东亚银行',
        'GDB'	=> '广发银行',
        'CNCB' => '中信银行',
        'ABC'	=> '农业银行',
        'PAB'	=> '平安银行',
        'SPDB'	=> '浦发银行',
        'BOCOM'	=> '交通银行',
        'PSBC'	=> '邮政银行',
        'CMB'	=> '招商银行',
        'CMBC' => '民生银行',
        'ICBC' => '工商银行',
        'BOS' =>'上海银行'
    }

    def initialize(result)
      self.raw = result.to_s
      self.msg = result
    end

    def success?
      @msg['returnCode'] == RESULT_SUCCESS_FLAG
    end
  end
end