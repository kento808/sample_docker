require 'rails_helper'

RSpec.describe Notification, type: :model do
  before do
    @notice = Notification.new(visitor_id: 1, visited_id: 2, action: 'follow')
  end

  describe 'valid notification' do
    it 'valid notification' do
      @notice.valid?
      expect(@notice).to be_valid
    end

    it 'invalid visitor_id nil' do
      @notice.visitor_id = ""
      @notice.valid?
      expect(@notice).to be_invalid
    end

    it 'invalid visited_id nil' do
      @notice.visited_id = nil
      @notice.valid?
      expect(@notice).to be_invalid
    end
  end
end
