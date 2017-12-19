require 'digest/md5'
module NeotelisPay
  module Utils
    class Crypt
      def self.crypt_md5(source_msg, key)
        k_ipad = Array.new(64, 54)
        k_opad = Array.new(64, 92)
        key_arr = key.unpack('c*')
        for i in 0..(key_arr.size - 1)
          k_ipad[i] = key_arr[i] ^ 54
          k_opad[i] = key_arr[i] ^ 92
        end
        k_ipad_str = k_ipad.pack('c*')
        k_opad_str = k_opad.pack('c*')

        md1 = ''
        md2 = ''
        #取签名原文和空值进行一次MD5签名
        md1 = Digest::MD5.digest(k_ipad_str + source_msg)
        #取第一次签名后的值和商户秘钥再次MD5签名
        md2 = Digest::MD5.hexdigest(k_opad_str + md1)
        return md1, md2
      end
    end
  end
end
