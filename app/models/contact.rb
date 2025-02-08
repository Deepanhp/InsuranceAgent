class Contact < ApplicationRecord
  validates :name, :email, :phone, :subject, :message, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  
  before_create :set_default_status
  
  private
  
  def set_default_status
    self.status ||= 'pending'
  end
end
