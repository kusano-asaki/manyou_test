FactoryBot.define do
  factory :task do
    name { 'task' }
    content { 'Factoryで作ったデフォルトのコンテント１' }
    end_at { '2020-09-03' }
  end
end
