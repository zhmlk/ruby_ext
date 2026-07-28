require "rails_helper"

RSpec.describe String do
  describe "#extract_hostname" do
    subject(:hostname) { input.extract_hostname }

    context "with a full URL" do
      let(:input) { "https://e-sign.co.uk/c/123" }

      it { is_expected.to eq("e-sign.co.uk") }
    end

    context "with a URL without a scheme" do
      let(:input) { "e-sign.co.uk/c/123" }

      it { is_expected.to eq("e-sign.co.uk") }
    end

    context "with a bare hostname" do
      let(:input) { "e-sign.co.uk" }

      it { is_expected.to eq("e-sign.co.uk") }
    end

    context "with a subdomain" do
      let(:input) { "www.e-sign.co.uk" }

      it { is_expected.to eq("www.e-sign.co.uk") }
    end

    context "with a multi-level hostname" do
      let(:input) { "opul.test.co.uk" }

      it { is_expected.to eq("opul.test.co.uk") }
    end

    context "with an email address" do
      let(:input) { "someone@e-sign.co.uk" }

      it { is_expected.to eq("e-sign.co.uk") }
    end

    context "with an email on a subdomain" do
      let(:input) { "someone@www.e-sign.co.uk" }

      it { is_expected.to eq("www.e-sign.co.uk") }
    end

    context "with multiple @ symbols" do
      let(:input) { "someone@e-sign.co.uk@foo.com" }

      it { is_expected.to eq("e-sign.co.uk") }
    end

    context "with uppercase letters and whitespace" do
      let(:input) { "  HTTPS://WWW.E-SIGN.CO.UK/C/123  " }

      it { is_expected.to eq("www.e-sign.co.uk") }
    end

    context "with an invalid hostname" do
      let(:input) { "not a hostname" }

      it { is_expected.to be_nil }
    end

    context "with an empty string" do
      let(:input) { "" }

      it { is_expected.to be_nil }
    end
  end

  describe "#extract_domain" do
    subject(:domain) { input.extract_domain }

    context "with a full URL" do
      let(:input) { "https://e-sign.co.uk/c/123" }

      it { is_expected.to eq("e-sign.co.uk") }
    end

    context "with a URL without a scheme" do
      let(:input) { "e-sign.co.uk/c/123" }

      it { is_expected.to eq("e-sign.co.uk") }
    end

    context "with a bare domain" do
      let(:input) { "e-sign.co.uk" }

      it { is_expected.to eq("e-sign.co.uk") }
    end

    context "with a www subdomain" do
      let(:input) { "www.e-sign.co.uk" }

      it { is_expected.to eq("e-sign.co.uk") }
    end

    context "with an email address" do
      let(:input) { "someone@e-sign.co.uk" }

      it { is_expected.to eq("e-sign.co.uk") }
    end

    context "with an email on a subdomain" do
      let(:input) { "someone@www.e-sign.co.uk" }

      it { is_expected.to eq("e-sign.co.uk") }
    end

    context "with a multi-part TLD" do
      let(:input) { "https://foo.bar.co.uk/path" }

      it { is_expected.to eq("bar.co.uk") }
    end

    context "with uppercase letters and whitespace" do
      let(:input) { "  HTTPS://e-sign.co.uk/C/123  " }

      it { is_expected.to eq("e-sign.co.uk") }
    end

    context "with multiple @ symbols" do
      let(:input) { "someone@e-sign.co.uk@foo.com" }

      it { is_expected.to eq("e-sign.co.uk") }
    end

    context "with an invalid domain" do
      let(:input) { "not a domain" }

      it { is_expected.to be_nil }
    end

    context "with an empty string" do
      let(:input) { "" }

      it { is_expected.to be_nil }
    end

    context "with nil converted to string" do
      let(:input) { nil.to_s }

      it { is_expected.to be_nil }
    end
  end
end
