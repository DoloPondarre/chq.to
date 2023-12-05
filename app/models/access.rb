class Access < ApplicationRecord
  belongs_to :link

  validates :ip_address, presence: true
end
