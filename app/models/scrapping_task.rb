class ScrappingTask < ApplicationRecord
  scope :by_session, ->(uuid) { where('uuid IS NOT NULL').where(uuid: uuid) }
end
