class Task < ApplicationRecord
  validates :name,  presence: true
  validates :content,  presence: true

  scope :name_like, -> (query) { where("name LIKE ?", "%#{ query }%")}
  scope :completed_like, -> (query) { where(completed: query)}
end
