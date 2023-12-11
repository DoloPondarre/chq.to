class Access < ApplicationRecord
  include Groupdate
  
  belongs_to :link

  validates :ip_address, presence: true

  scope :filter_by_ip, ->(ip) { where('ip_address LIKE ?', "%#{ip}%") if ip.present? }
  scope :filter_by_date_range, ->(start_date, end_date) {
    if start_date.present? && end_date.present?
      where(created_at: start_date..end_date)
    elsif start_date.present? || end_date.present?
      # Agregar mensaje de error al flash
      flash[:error] = 'Both start and end dates are required for date range filtering'
      none
    else
      all
    end
  }
end
