# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe '#tilte' do
    it 'status default' do
      coupon = described_class.new(code: 'NATAL10-001', status: :active)
      expect(coupon.title).to eq('NATAL10-001 (disponível)')
    end

    it 'status must be active' do
      coupon = described_class.new(code: 'NATAL10-001', status: :active)
      expect(coupon.title).to eq('NATAL10-001 (disponível)')
    end
  end
end
