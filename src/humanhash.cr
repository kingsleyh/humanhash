require "uuid"
require "./word_list"

module HumanHash
  struct HumanUuid
    property human, uuid, digest

    def initialize(@human : String, @uuid : String, @digest : String)
    end
  end

  DEFAULT_WORDS     = 4
  DEFAULT_SEPARATOR = '-'

  class HumanHasher
    getter words : Int32
    getter separator : Char | String
    getter word_list : Array(Tuple(String, String))

    def initialize(@words : Int32 = DEFAULT_WORDS, @separator : (Char | String) = DEFAULT_SEPARATOR, @word_list : Array(Tuple(String, String)) = DEFAULT_WORDLIST)
    end

    def humanize(hexdigest)
      raise "You must provide a valid SHA256 hex digest" unless hexdigest.hexbytes?
      bytes = hexdigest.hexbytes
      compress(bytes, words).to_a.map_with_index { |x, i| word_list[x][i.even? ? 0 : 1] }.join(separator)
    end

    def uuid
      r = UUID.random
      digest = r.hexstring
      uuid = r.to_s
      HumanUuid.new(humanize(digest), uuid, digest)
    end

    private def compress(bytes, target)
      len = bytes.size
      return bytes unless target < len

      segment_size = (len / target) + 1
      bytes.each_slice(segment_size.to_i).map { |x| x.reduce { |s, b| s ^ b } }
    end
  end

  def self.humanize(hexdigest, words : Int32 = DEFAULT_WORDS, separator : (Char | String) = DEFAULT_SEPARATOR, word_list : Array(Tuple(String, String)) = DEFAULT_WORDLIST) : String
    h = HumanHasher.new(words, separator, word_list)
    h.humanize(hexdigest)
  end

  def self.uuid(words : Int32 = DEFAULT_WORDS, separator : (Char | String) = DEFAULT_SEPARATOR, word_list : Array(Tuple(String, String)) = DEFAULT_WORDLIST)
    h = HumanHasher.new(words, separator, word_list)
    h.uuid
  end
end
