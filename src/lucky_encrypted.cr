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

    @encryptor : ::Lucky::MessageEncryptor

    def initialize(@encrypted : String)
      @encryptor = ::Lucky::MessageEncryptor.new(ENV["ENCRYPTED_SECRET"])
    end

    def initialize(encrypted : Slice(UInt8))
      @encrypted = String.new(encrypted)
      @encryptor = ::Lucky::MessageEncryptor.new(ENV["ENCRYPTED_SECRET"])
    end

    def to_s
      value
    end

    private def value
      @encrypted.strip.downcase
    end

    def blank?
      @encrypted.blank?
    end

    module Lucky
      alias ColumnType = String
      include Avram::Type

      def parse(value : StringEncrypted)
        encryptor = ::Lucky::MessageEncryptor.new(ENV["ENCRYPTED_SECRET"])
        SuccessfulCast(StringEncrypted).new(encryptor.verify_and_decrypt(value))
      end

      def parse(value : String)
        encryptor = ::Lucky::MessageEncryptor.new(ENV["ENCRYPTED_SECRET"])
        SuccessfulCast(StringEncrypted).new(StringEncrypted.new(encryptor.verify_and_decrypt(value)))
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
