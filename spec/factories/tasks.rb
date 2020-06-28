FactoryBot.define do
  factory :task do
    name { 'task' }
    content { 'Factoryで作ったデフォルトのコンテント１' }
  end
  # factory :second_task, class: Task do
  #   name { 'task2' }
  #   contetnt { 'Factoryで作ったデフォルトのコンテント2' }
  # end
end
