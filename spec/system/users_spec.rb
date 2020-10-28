require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'User CRUD' do
    describe 'ログイン前' do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }

      context '簡単ログインでログインできる' do
        it 'アカウント編集へはアクセスできない' do
          visit root_path
          click_on '簡単ログイン'
          expect(page).to have_content 'ゲストユーザーとしてログインしました'
          click_on 'マイページ'
          click_on 'アカウント編集'
          expect(page).to have_content 'ゲストユーザーのため変更できません'
        end
        it '簡単ログイン後、ログアウトできる' do
          visit root_path
          click_on '簡単ログイン'
          click_on 'ログアウト'
          expect(page).to have_content 'ログアウトしました。'
          expect(current_path).to eq root_path
        end
      end

      describe 'ユーザー新規登録' do
        context 'フォームの入力値が正常' do
          it 'ユーザーの新規作成が成功' do
            # ユーザー新規登録画面へ遷移
            visit new_user_registration_path
            # Nameテキストフィールドにtestと入力
            fill_in 'user_name', with: 'test'
            # Emailテキストフィールドにtest@example.comと入力
            fill_in 'user_email', with: 'test@example.com'
            # Passwordテキストフィールドにpasswordと入力
            fill_in 'user_password', with: 'password'
            # Password confirmationテキストフィールドにpasswordと入力
            fill_in 'user_password_confirmation', with: 'password'
            # SignUpと記述のあるsubmitをクリックする
            click_button '登　録'
            # root_pathへ遷移することを期待する
            expect(current_path).to eq root_path
            # 遷移されたページに'アカウント登録が完了しました。'の文字列があることを期待する
            expect(page).to have_content 'アカウント登録が完了しました。'
          end
        end
        context 'メールアドレス未記入' do
          it 'ユーザーの新規作成が失敗' do
            # ユーザー新規登録画面へ遷移
            visit new_user_registration_path
            # Nameテキストフィールドにtestと入力
            fill_in 'user_name', with: 'test'
            # Emailテキストフィールドをnil状態にする
            fill_in 'user_email', with: nil
            # Passwordテキストフィールドにpasswordと入力
            fill_in 'user_password', with: 'password'
            # Password confirmationテキストフィールドにpasswordと入力
            fill_in 'user_password_confirmation', with: 'password'
            # SignUpと記述のあるsubmitをクリックする
            click_button '登　録'
            # '/users'へ遷移することを期待する
            expect(current_path).to eq '/users'
            # 遷移されたページに'メールアドレスを入力してください'の文字列があることを期待する
            expect(page).to have_content 'メールアドレスを入力してください'
          end
        end
        context '登録済メールアドレス' do
          it 'ユーザーの新規作成が失敗する' do
            # ユーザー新規登録画面へ遷移
            visit new_user_registration_path
            # Nameテキストフィールドにtestと入力
            fill_in 'user_name', with: 'test'
            # Emailテキストフィールドにlet(:user)に定義したユーザーデータのemailを入力
            fill_in 'user_email', with: user.email
            # Passwordテキストフィールドにpasswordと入力
            fill_in 'user_password', with: 'password'
            # Password confirmationテキストフィールドにpasswordと入力
            fill_in 'user_password_confirmation', with: 'password'
            # SignUpと記述のあるsubmitをクリックする
            click_button '登　録'
            # '/users'へ遷移することを期待する
            expect(current_path).to eq '/users'
            # 遷移されたページに'メールアドレスはすでに存在します'の文字列があることを期待する
            expect(page).to have_content "メールアドレスはすでに存在します"
          end
        end
      end
    end

    describe 'ログイン' do
      before do
        @user = User.create!(name: 'test', email: 'test@example.com', password: 'password')
      end
      context 'フォームの入力値が正常' do
        it 'ユーザーのログインが成功' do
          # ログイン画面へ遷移
          visit new_user_session_path
          fill_in 'user_email', with: 'test@example.com'
          fill_in 'user_password', with: 'password'
          click_button 'ログイン'
          # root_pathへ遷移することを期待する
          expect(current_path).to eq root_path
          # 遷移されたページに'ログインしました。'の文字列があることを期待する
          expect(page).to have_content 'ログインしました。'
          click_on 'ログアウト'
          expect(page).to have_content 'ログアウトしました。'
          expect(current_path).to eq root_path
        end
      end
      context 'メールアドレス未記入' do
        it 'ログイン失敗' do
          # ログイン画面へ遷移
          visit new_user_session_path
          fill_in 'user_email', with: nil
          fill_in 'user_password', with: 'password'
          click_button 'ログイン'
          # /users/sign_inへ遷移することを期待する
          expect(current_path).to eq "/users/sign_in"
          # 遷移されたページに'ログインしました。'の文字列があることを期待する
          expect(page).to have_content 'メールアドレス もしくはパスワードが不正です。'
        end
      end
    end

    describe 'ログイン後' do
      before do
        @user = User.create(name: 'yamada', email: 'yamada@example.com', password: 'password')
        login_as(@user)
        visit edit_user_registration_path(@user)
      end
      describe 'ユーザー編集' do
        context 'フォームの入力値が正常' do
          it 'ユーザーの編集が成功(ユーザー画像追加)' do
            expect(current_path).to eq edit_user_registration_path(@user)
            expect(page).to have_content('アカウント編集')
            # Nameに"yamada"が入力されていることを検証する
            expect(page).to have_field 'user_name', with: 'yamada'
            # Emailに"yamada@example.com"が入力されていることを検証する
            expect(page).to have_field 'user_email', with: 'yamada@example.com'
            # ユーザー画像追加
            attach_file 'user_picture', "#{Rails.root}/spec/cafe01.jpg"
            fill_in 'user_current_password', with: 'password'
            fill_in 'user_password', with: 'password'
            fill_in 'user_password_confirmation', with: 'password'
            click_button '保　存'
            expect(current_path).to eq root_path(@user)
            expect(page).to have_content 'アカウント情報を変更しました。'
          end
          it 'ユーザーの編集が成功(パスワード変更)' do
            # Nameに"test"が入力されていることを検証する
            expect(page).to have_field 'user_name', with: 'yamada'
            # Emailに"test@example.com"が入力されていることを検証する
            expect(page).to have_field 'user_email', with: 'yamada@example.com'
            fill_in 'user_current_password', with: 'password'
            fill_in 'user_password', with: '123456'
            fill_in 'user_password_confirmation', with: '123456'
            click_button '保　存'
            expect(current_path).to eq root_path(@user)
            expect(page).to have_content 'アカウント情報を変更しました。'
          end
        end
        context 'パスワードが一致しない' do
          it 'ユーザーの編集が失敗' do
            expect(page).to have_field 'user_name', with: 'yamada'
            expect(page).to have_field 'user_email', with: 'yamada@example.com'
            fill_in 'user_current_password', with: 'password'
            fill_in 'user_password', with: '123456'
            fill_in 'user_password_confirmation', with: '23456'
            click_button '保　存'
            expect(current_path).to eq '/users'
            expect(page).to have_content "確認用パスワードとパスワードの入力が一致しません"
          end
        end
      end
    end
  end
end
  
  



  
