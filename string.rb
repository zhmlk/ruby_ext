class String

  # Shuffles the characters of the current string (self) randomly.
  # @return [String] A new string with the characters shuffled.
  def shuffle
    chars.shuffle.join
  end

  # Securely shuffles the characters of the current string (self) randomly.
  # If the string has fewer than 2 unique characters, it returns the original string.
  # It ensures that the shuffled string is different from the original string.
  # If the shuffled string is the same as the original, it recursively shuffles again.
  # @return [String] A new string with the characters securely shuffled.
  def secure_shuffle
    return self if chars.uniq.size < 2 # returns self if string is empty or has all identical characters returns (eg "" or "aaa")
    val = shuffle
    val == self ? secure_shuffle : val
  end

  # Checks if the current string (self) is a valid email address.
  # A valid email address matches the pattern:
  # - Starts with one or more word characters, plus signs, hyphens, or dots.
  # - Followed by an '@' symbol.
  # - Followed by one or more lowercase letters, digits, hyphens, or dots.
  # - Followed by a dot and one or more lowercase letters.
  # The match is case-insensitive.
  # @return [Boolean] True if the string is a valid email address, false otherwise.
  def valid_email?
    self.match?(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
  end

  # Checks if the current string (self) is a valid hex color code.
  # A valid hex color code starts with a '#' followed by exactly 6 hexadecimal digits.
  # The match is case-insensitive.
  # @return [Boolean] True if the string is a valid hex color code, false otherwise.
  def hex_colour?
    self.match?(/^#[0-9A-F]{6}$/i)
  end

  # Checks if the current string (self) is a valid transparent hex color code.
  # A valid transparent hex color code starts with a '#' followed by 6 hexadecimal digits,
  # and optionally followed by 2 more hexadecimal digits for transparency.
  # The match is case-insensitive.
  # @return [Boolean] True if the string is a valid transparent hex color code, false otherwise.
  def transparent_hex_colour?
    self.match?(/^#[0-9A-F]{6}[0-9a-f]{0,2}$/i)
  end

  # Computes the SHA-256 hash of the current object (self).
  # Uses the Digest::SHA256 library to generate the hash.
  # @return [String] The SHA-256 hexadecimal hash of the object.
  def to_sha256
    Digest::SHA256.hexdigest(self)
  end

  # Computes the SHA-1 hash of the current object (self).
  # Uses the Digest::SHA1 library to generate the hash.
  # @return [String] The SHA-1 hexadecimal hash of the object.
  def to_sha1
    Digest::SHA1.hexdigest(self)
  end

  # Generates a deterministic hexadecimal string of a specified length.
  # The method uses the SHA256 hash of the string (self) as a seed for a random number generator.
  # This ensures that the same input string will always produce the same output string.
  #
  # @param len [Integer] the length of the resulting hexadecimal string (default is 10)
  # @return [String] a deterministic hexadecimal string of the specified length
  def deterministic_hex(len = 8)
    numeric_seed = Digest::SHA256.hexdigest(self).to_i(16)
    rng = Random.new(numeric_seed)
    Array.new(len) { rng.rand(16).to_s(16) }.join
  end

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
