require "uuid"
require "./word_list"

module HumanHash
  struct HumanUuid
    property human, uuid, digest

    def initialize(@human : String, @uuid : String, @digest : String)
    end
  end

  Default_words     = 4
  Default_separator = "-"
  Default_word_list = DEFAULT_WORDLIST

  class HumanHasher
    getter words : Int32
    getter separator : String
    getter word_list : Array(String)

    def initialize(@words : Int32 = Default_words, @separator : String = Default_separator, @word_list : Array(String) = Default_word_list)
    end

    def humanize(hexdigest)
      raise "You must provide a valid SHA256 hex digest" unless hexdigest.hexbytes?
      bytes = hexdigest.hexbytes
      compress(bytes, words).to_a.map { |x| word_list[x] }.join(separator)
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
      bytes.each_slice(segment_size).map { |x| x.reduce { |s, b| s ^ b } }
    end
  end

  def self.humanize(hexdigest, words : Int32 = Default_words, separator : String = Default_separator, word_list : Array(String) = Default_word_list)
    h = HumanHasher.new(words, separator, word_list)
    h.humanize(hexdigest)
  end

  def self.uuid(words : Int32 = Default_words, separator : String = Default_separator, word_list : Array(String) = Default_word_list)
    h = HumanHasher.new(words, separator, word_list)
    h.uuid
  end
end
