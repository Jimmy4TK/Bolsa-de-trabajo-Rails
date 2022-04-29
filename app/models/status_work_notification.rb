class StatusWorkNotification < ApplicationRecord
    enum status: {contratado: 3, interesa: 1, rechazado: 2, pendiente:0}
    belongs_to :candidate
    belongs_to :work_notification
end
