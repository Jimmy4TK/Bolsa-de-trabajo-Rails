class Candidate < ApplicationRecord
    has_many :status_work_notifications, dependent: :destroy
    has_many :work_notifications, through: :status_work_notifications
end
