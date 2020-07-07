class Task < ApplicationRecord
  validates :name,  presence: true
  validates :content,  presence: true

  scope :name_like, -> (query) { where("name LIKE ?", "%#{ query }%")}
  scope :completed_like, -> (query) { where(completed: query)}

  enum priority: { 低: 0, 中: 1, 高: 2 }
end
