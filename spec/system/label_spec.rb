require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @label = FactoryBot.create(:label)
    @label1 = FactoryBot.create(:label1)
    visit new_session_path
    fill_in 'session[email]', with: 'sss@sss.com'
    fill_in 'session[password]', with: '123456789'
    click_on 'Log in'
    @task　= FactoryBot.create(:task, user: @user)
    @second_task = FactoryBot.create(:task, name: 'task2', end_at: '2020-08-03', completed: '未着手', priority: '高', user: @user)
    @labelling = FactoryBot.create(:labelling)
    @second_labelling = FactoryBot.create(:second_labelling)
  end
  describe 'ラベル管理' do
    context 'ラベルが登録されていない場合' do
      it 'ラベルを登録する' do
        visit new_task_path
        fill_in 'task_name', with: 'testtest'
        fill_in 'task_content', with: 'content1'
        select '高', from: 'task_priority'
        select '未着手', from: 'task_completed'
        check 'task_label_ids_1'
        click_on 'commit'
        expect(page).to have_content 'プライベート'
      end
      it '複数ラベルの登録' do
        visit new_task_path
        fill_in 'task_name', with: 'testtest'
        fill_in 'task_content', with: 'content1'
        select '高', from: 'task_priority'
        select '未着手', from: 'task_completed'
        check 'task_label_ids_1'
        check 'task_label_ids_2'
        click_on 'commit'
        expect(page).to have_content 'プライベート'
        expect(page).to have_content '仕事'
      end
    end
    context 'ラベル検索' do
      it 'ラベルでのタスク検索' do
        visit tasks_path
        select 'プライベート', from: 'label_id'
        click_button 'commit'
        expect(page).to have_content 'プライベート'
      end
      it 'ラベルと名前での検索' do
        visit tasks_path
        fill_in "name", with: 'task2'
        select '仕事', from: 'label_id'
        click_button 'commit'
        expect(page).to have_content 'task2'
      end
      it 'ラベルと進捗での検索' do
        visit tasks_path
        select '未着手', from: 'completed'
        select '仕事', from: 'label_id'
        click_button 'commit'
        expect(page).to have_content 'task2'
      end
      it '名前とラベルと進捗での検索' do
        visit tasks_path
        fill_in "name", with: 'task2'
        select '未着手', from: 'completed'
        select '仕事', from: 'label_id'
        click_button 'commit'
        expect(page).to have_content 'task2'
      end
    end
  end
end
