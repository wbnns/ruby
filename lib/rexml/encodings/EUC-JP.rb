begin
	require 'uconv'

	module REXML
		module Encoding
			def decode(str)
				return Uconv::euctou8(str)
			end

			def encode content
				return Uconv::u8toeuc(content)
			end
		end
	end
rescue LoadError
  begin
		require 'iconv'
		module REXML
			module Encoding
				def decode(str)
					return Iconv::iconv("utf-8", "euc-jp", str)[0]
				end

				def encode content
					return Iconv::iconv("euc-jp", "utf-8", content)[0]
				end
			end
		end
  rescue LoadError
		raise "uconv or iconv is required for Japanese encoding support."
  end
end
