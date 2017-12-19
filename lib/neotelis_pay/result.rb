module NeotelisPay
  class Result
    attr_accessor :raw, :msg

    RESULT_SUCCESS_FLAG = '000000'

    def initialize(result)
      self.raw = result
      self.msg = JSON.parse(result)
    end

    def success?
      @msg['returnCode'] == RESULT_SUCCESS_FLAG
    end
  end
end