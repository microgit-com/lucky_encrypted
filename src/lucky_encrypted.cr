require "lucky/support/message_encryptor"
require "lucky/renderable_error"
require "lucky/errors"
require "avram/type"
require "avram/criteria"
require "avram/charms/string_extensions"

module LuckyEncrypted
  VERSION = "0.1.0"

  class StringEncrypted
    def self.adapter
      Lucky
    end

    def initialize(@encrypted : String)
    end

    def initialize(encrypted : Slice(UInt8))
      @encrypted = String.new(encrypted)
    end

    def to_s : String
      value
    end

    def value
      @encrypted.strip
    end

    def blank?
      @encrypted.blank?
    end

    module Lucky
      alias ColumnType = String
      include Avram::Type

      def from_db!(value : String)
        encryptor = ::Lucky::MessageEncryptor.new(ENV["ENCRYPTED_SECRET"])
        parse(String.new(encryptor.verify_and_decrypt(value)))
      end

      def parse(value : StringEncrypted)
        SuccessfulCast(StringEncrypted).new(value)
      end

      def parse(value : String)
        SuccessfulCast(StringEncrypted).new(StringEncrypted.new(value))
      end

      def to_db(value : String)
        encryptor = ::Lucky::MessageEncryptor.new(ENV["ENCRYPTED_SECRET"])
        encryptor.encrypt_and_sign(StringEncrypted.new(value).to_s)
      end

      def to_db(value : StringEncrypted)
        encryptor = ::Lucky::MessageEncryptor.new(ENV["ENCRYPTED_SECRET"])
        encryptor.encrypt_and_sign(value.to_s)
      end

      class Criteria(T, V) < String::Lucky::Criteria(T, V)
        @upper = false
        @lower = false
      end
    end
  end
end
