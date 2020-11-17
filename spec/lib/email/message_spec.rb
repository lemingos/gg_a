require 'rails_helper'

RSpec.describe Email::Message, type: :service do
  describe "#deliver" do
    let(:attributes) { {email: 'test@example.com', subject: 'Hello', body: 'message'}  }
    subject { described_class.new(attributes) }

    it "should failover to Mailgun and raise an error" do
      stub_request(:post, "https://api.sendgrid.com/v3/mail/send")
        .to_return(status: 400, body: "", headers: {})
      stub_request(:post, "https://api.mailgun.net/v3/#{ENV['MAILGUN_DOMAIN']}/messages").
         to_return(status: 400, body: "", headers: {})

      expect_any_instance_of(Email::Providers::SendgridProvider).to receive(:deliver).once.and_call_original
      expect_any_instance_of(Email::Providers::MailgunProvider).to receive(:deliver).once.and_call_original

      expect { subject.deliver }.to raise_error(Email::ApiError, 'message not delivered')
    end

    it "should failover to Mailgun and succeed" do
      stub_request(:post, "https://api.sendgrid.com/v3/mail/send")
        .to_return(status: 400, body: "", headers: {})
      stub_request(:post, "https://api.mailgun.net/v3/#{ENV['MAILGUN_DOMAIN']}/messages").
         to_return(status: 200, body: "", headers: {})

      expect_any_instance_of(Email::Providers::SendgridProvider).to receive(:deliver).once.and_call_original
      expect_any_instance_of(Email::Providers::MailgunProvider).to receive(:deliver).once.and_call_original

      subject.deliver
    end

    it "should not failover on success send" do
      stub_request(:post, "https://api.sendgrid.com/v3/mail/send").to_return(status: 200, body: "", headers: {})
      expect_any_instance_of(Email::Providers::SendgridProvider).to receive(:deliver).once.and_call_original
      expect_any_instance_of(Email::Providers::MailgunProvider).to receive(:deliver).never

      subject.deliver
    end
  end
end
