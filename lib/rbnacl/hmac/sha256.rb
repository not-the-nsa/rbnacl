# encoding: binary
module RbNaCl
  module HMAC
    # Computes an authenticator as HMAC-SHA-256
    #
    # The authenticator can be used at a later time to verify the provenance of
    # the message by recomputing the HMAC over the message and then comparing it to
    # the provided authenticator.  The class provides methods for generating
    # signatures and also has a constant-time implementation for checking them.
    #
    # This is a secret key authenticator, i.e. anyone who can verify signatures
    # can also create them.
    #
    # @see http://nacl.cr.yp.to/auth.html
    class SHA256 < Auth
      # Number of bytes in a valid key
      KEYBYTES = NaCl::HMACSHA256_KEYBYTES

      # Number of bytes in a valid authenticator
      BYTES = NaCl::HMACSHA256_BYTES

      # The crypto primitive for the HMAC::SHA256 class
      #
      # @return [Symbol] The primitive used
      def self.primitive
        :hmac_sha256
      end

      private
      def compute_authenticator(authenticator, message)
        NaCl.crypto_auth_hmacsha256(authenticator, message, message.bytesize, key)
      end

      def verify_message(authenticator, message)
        NaCl.crypto_auth_hmacsha256_verify(authenticator, message, message.bytesize, key)
      end
    end
  end
end
