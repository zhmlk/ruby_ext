class String

  # Converts the current object (self) to a boolean value.
  # Uses ActiveModel::Type::Boolean to cast the value.
  # If the cast result is nil, it returns false.
  # @return [Boolean] The boolean representation of the object.
  def to_b
    ActiveModel::Type::Boolean.new.cast(self) || false
  end

  # Encrypts and signs the current object (self) using the provided arguments.
  # The arguments are the same as those used in ActiveSupport::MessageEncryptor.
  # @param args [Hash] Optional arguments for the encryption and signing process.
  # @return [String] The encrypted and signed string.
  def encrypt_and_sign(**args)
    message_encryptor.encrypt_and_sign(self, **args)
  end

  # Decrypts and verifies the current object (self) using the provided arguments.
  # The arguments are the same as those used in ActiveSupport::MessageEncryptor.
  # @param args [Hash] Optional arguments for the decryption and verification process.
  # @return [String, nil] The decrypted and verified string, or nil if decryption fails.
  def decrypt_and_verify(**args)
    message_encryptor.decrypt_and_verify(self, **args)
  rescue
    nil
  end

  private
  # Returns an instance of ActiveSupport::MessageEncryptor.
  # This instance is initialized with a key derived from an environment variable.
  # If the environment variable 'message_enc_key' is not set, a default key is used.
  # This encryptor is used for encrypting and decrypting messages,
  # as well as signing and verifying them.
  # @return [ActiveSupport::MessageEncryptor] The message encryptor instance.
  def message_encryptor
    ActiveSupport::MessageEncryptor.new(ENV['message_enc_key'] || 'cc7451ca1911acb363022d0a25d3b1e7')
  end
  
end
