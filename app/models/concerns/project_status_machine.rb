module ProjectStatusMachine
  extend ActiveSupport::Concern

  included do
    include AASM

    enum status: {
      wait_comments: 1,
      with_comments: 2,
      accepted: 3
    }

    aasm column: :status, enum: true do
      state :wait_comments, initial: true
      state :with_comments, :accepted

      event :accept do
        transitions from: :wait_comments,
                    to: :accepted
      end

      event :not_accept do
        transitions from: :wait_comments,
                    to: :with_comments
      end

      event :updates do
        transitions from: [:wait_comments, :with_comments, :accepted],
                    to: :wait_comments,
                    after: :update_notifications!
      end
    end
  end
end
