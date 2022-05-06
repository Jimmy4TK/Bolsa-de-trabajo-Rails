class WorkNotification < ApplicationRecord
    #Relations
    belongs_to :company
    has_many :status_work_notifications, dependent: :destroy
    has_many :candidates, through: :status_work_notifications
end
