require 'spec_helper'

describe Admin::Authenticator do
  describe '#authenticate' do

    example 'Should return true if correct password' do
      m = build(:administrator)
      expect(Admin::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

    example 'Should return false if incorrect password' do
      m = build(:administrator)
      expect(Admin::Authenticator.new(m).authenticate('ashdahsud')).to be_falsey
    end

    example 'Should return false if password not set' do
      m = build(:administrator, password: nil)
      expect(Admin::Authenticator.new(m).authenticate(nil)).to be_falsey
    end

    example 'Should return true even if suspended' do
      m = build(:administrator, suspended: true)
      expect(Admin::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

  end
end