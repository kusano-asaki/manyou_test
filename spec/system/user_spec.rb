require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do
  describe 'ユーザ登録のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'ユーザ新規登録のテスト' do
        visit new_user_path
        fill_in 'user[name]', with: 'sample1'
        fill_in 'user[email]', with: 'sss@sss.com'
        fill_in 'user[password]', with: '123456789'
        fill_in 'user[password_confirmation]', with: '123456789'
        click_on 'Create my account'
        expect(page).to have_content 'sample1'
      end
      it 'ログインしていない時はログイン画面に飛ぶテスト' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe 'セッション機能のテスト' do
    before do
      @user = FactoryBot.create(:user)
    end
    context 'ユーザのデータがありログインしていない場合' do
      it 'ログインができる' do
        visit new_session_path
        fill_in 'session[email]', with: 'sss@sss.com'
        fill_in 'session[password]', with: '123456789'
        click_on 'Log in'
        expect(current_path).to eq user_path(id: @user.id)
      end
    end
    context 'ログインしている場合' do
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'sss@sss.com'
        fill_in 'session[password]', with: '123456789'
        click_on 'Log in'
      end
      it '自分のマイページに飛べる' do
        visit user_path(id: @user.id)
        expect(current_path).to eq user_path(id: @user.id)
      end
      it ' 一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること' do
        @admin_user = FactoryBot.create(:admin_user)
        visit user_path(id: @admin_user.id)
        expect(page).to have_content '他のユーザーへのアクセスはできません'
      end
      it 'ログアウトできる' do
        visit user_path(id: @user.id)
        click_on 'Logout'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理画面のテスト' do
    context '管理者がいない状態' do
      it '管理者は管理画面にアクセスできること' do
        FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session[email]', with: 'adminsss@sss.com'
        fill_in 'session[password]', with: '12345678910'
        click_on 'Log in'
        visit admin_users_path
        expect(page).to have_content '管理者画面 ユーザー一覧'
      end
      it '一般ユーザは管理画面にアクセスできないこと' do
        FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session[email]', with: 'sss@sss.com'
        fill_in 'session[password]', with: '123456789'
        click_on 'Log in'
        visit admin_users_path
        expect(page).to have_content 'あなたは管理者ではありません'
      end
    end
    context '管理者でログインしている状態' do
      before do
        FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session[email]', with: 'adminsss@sss.com'
        fill_in 'session[password]', with: '12345678910'
        click_on 'Log in'
        visit admin_users_path
      end
      it '管理者はユーザを新規登録できること' do
        click_on 'New User'
        fill_in 'user[name]', with: 'admin2'
        fill_in 'user[email]', with: 'admin2@sss.com'
        fill_in 'user[password]', with: '223456789'
        fill_in 'user[password_confirmation]', with: '223456789'
        click_on '登録する'
        expect(page).to have_content 'admin2'
      end
      it '管理者はユーザの詳細画面にアクセスできること' do
        @user = FactoryBot.create(:user)
        visit admin_user_path(id: @user.id)
        expect(page).to have_content 'sample1'
      end
      it '管理者はユーザの編集画面からユーザを編集できること' do
        @user = FactoryBot.create(:user)
        visit edit_admin_user_path(id: @user.id)
        fill_in 'user[name]', with: 'sample2'
        fill_in 'user[email]', with: 'sss2@sss.com'
        fill_in 'user[password]', with: '22123456789'
        fill_in 'user[password_confirmation]', with: '22123456789'
        click_on '更新する'
        expect(page).to have_content 'sample2'
      end
      it '管理者はユーザの削除をできること' do
        @user3 = FactoryBot.create(:user, name: 'sample3', email: '3sss@sss.com')
        visit admin_users_path
        within "#destroy_#{@user3.name}" do
          click_on 'Destroy'
        end
        page.accept_confirm "Are you sure?"
        expect(page).to have_content 'User情報を削除しました'
      end
    end
  end

end
