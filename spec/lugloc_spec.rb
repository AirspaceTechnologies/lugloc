require 'spec_helper'

describe Lugloc do
  before do
    ENV['lugloc_api_username'] = ENV['lugloc_api_password'] = ENV['lugloc_client_id'] = ENV['lugloc_secret'] = 'x'
  end

  it 'has a version number' do
    expect(Lugloc::VERSION).not_to be nil
  end

  it 'calls get_token with reasonable values' do
    expect(Lugloc).to receive(:get_token) {|**c| @token_request = c}

    expect_any_instance_of(Net::HTTP).to receive(:request) {o = Object.new; def o.body; end; o}
    Lugloc.get_location(device_id: 'foo')
  end

  describe 'calls call_api with reasonable values' do
    before do
      expect(Lugloc).to receive(:call_api) {|**c| @api_request = c}
    end

    it 'can get a Lugloc''s location' do
      Lugloc.get_location(device_id: 'foo')

      expect(@api_request)
          .to match(
                  net_method: Net::HTTP::Get,
                  path:       "",
                  device_id:  "foo")
    end

    it 'can get a lugloc''s history' do
      Lugloc.get_history(device_id: 'foo')

      expect(@api_request)
          .to match(
                  net_method: Net::HTTP::Get,
                  path:       "locationHistory",
                  device_id:  "foo")
    end

    it 'can refresh a lugloc''s location' do
      Lugloc.refresh_location(device_id: 'foo')

      expect(@api_request)
          .to match(
                  net_method: Net::HTTP::Post,
                  path:       "refreshlocation",
                  device_id:  "foo")
    end

    it 'can turn off a lugloc' do
      Lugloc.turn_off(
          device_id: 'foo',
          minutes: 5
      )

      expect(@api_request)
          .to match(
              net_method: Net::HTTP::Post,
              path: "turnOff",
              query: {'minutes' => 5},
              device_id: "foo")
    end
  end
end
