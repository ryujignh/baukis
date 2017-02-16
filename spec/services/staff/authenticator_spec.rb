require 'rails_helper'

describe Staff::Authenticator do
  describe '#authenticate' do

    example 'Should return true if correct password' do
      m = build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

    example 'Should return false if incorrect password' do
      m = build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate('ashdahsud')).to be_falsey
    end

    example 'Should return false if password not set' do
      m = build(:staff_member, password: nil)
      expect(Staff::Authenticator.new(m).authenticate(nil)).to be_falsey
    end

    example 'Should return true even if suspended' do
      m = build(:staff_member, suspended: true)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

    example 'Should return false if not yet started' do
      m = build(:staff_member, start_date: Date.tomorrow)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end

    example 'Should return false if passed end date' do
      m = build(:staff_member, end_date: Date.yesterday)

      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end

  end
end