FactoryBot.define do
  factory :label do
    name { 'プライベート' }
  end
  factory :label1, class: Label do
    name { '仕事' }
  end
end
