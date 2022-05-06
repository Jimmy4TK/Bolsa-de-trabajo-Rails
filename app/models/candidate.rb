class Candidate < ApplicationRecord
    #Relations
    has_many :status_work_notifications, dependent: :destroy
    has_many :work_notifications, through: :status_work_notifications

    #Validations
    validates :name, presence: true
end
