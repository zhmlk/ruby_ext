module StringUtils
  module_function
  
  # Extracts the registrable domain from the given string.
  # Supports URLs (with or without a scheme), email addresses, and bare domains.
  # Returns the registrable domain (e.g. "google.com" or "example.co.uk"),
  # or nil if the string does not contain a valid domain.
  #
  # @return [String, nil] The registrable domain, or nil if no valid domain is found.
  def extract_domain(str)
    PublicSuffix.domain(extract_hostname(str))
  rescue
    nil
  end

  # Extracts a valid hostname from the given string.
  # Supports URLs (with or without a scheme), email addresses, and bare hostnames.
  # Returns the original hostname, including subdomains if present, or nil if the
  # string does not contain a valid hostname.
  #
  # @return [String, nil] The extracted hostname, or nil if no valid hostname is found.
  def extract_hostname(str)
    str = str.strip.downcase
    str = str.split("@").map{|s| extract_hostname(s)}.compact.first if str.include?("@")
    return nil unless str.present?
    str = "https://#{str}" unless str.match?(/\A[a-z][a-z0-9+\-.]*:\/\//i)
    uri = URI.parse(str)
    host = uri.host || str
    PublicSuffix.domain(host).present? ? host : nil
  rescue
    nil
  end

  # Ensures the given URL uses an HTTP or HTTPS scheme.
  # If the URL does not already start with "http://" or "https://",
  # "https://" is prepended. Otherwise, the original URL is returned.
  #
  # @return [String] The URL with an HTTP or HTTPS scheme.
  def ensure_https(url)
    url.match?(/\Ahttps?:\/\//) ? url : "https://#{url}"
  end
end
