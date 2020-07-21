FactoryBot.define do
  factory :labelling do
    task_id { Task.first.id }
    label_id { Label.first.id }
    end

  factory :second_labelling, class: Labelling do
    task_id { Task.second.id }
    label_id { Label.second.id }
    end
end
