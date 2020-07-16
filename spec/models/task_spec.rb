require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :model do
  before do
    @user = FactoryBot.create(:user)
    @task = FactoryBot.create(:task, user: @user)
    @second_task = FactoryBot.create(:task, name: 'bbbb', end_at: '2020-08-03', completed: '未着手', user: @user)
  end
  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(name: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end
  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗テスト', content: '')
    expect(task).not_to be_valid
  end
  it 'titleとcontentに内容が記載されていればバリデーションが通る' do
    task = Task.new(name: '成功テスト', content: '成功テスト', user: @user)
    expect(task).to be_valid
  end
describe 'scopeメソッドで検索をした場合' do
  it "scopeメソッドでタイトル検索ができる" do
    expect(Task.name_like('task').count).to eq 1
  end
  it "scopeメソッドでステータス検索ができる" do
    expect(Task.completed_like('未着手').count).to eq 1
  end
  it "scopeメソッドでタイトルとステータスの両方が検索できる" do
    expect(Task.name_like('bbbb').completed_like('未着手').count).to eq 1
  end
end
end
