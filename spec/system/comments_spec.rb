require 'rails_helper'
require 'resolv-replace'

RSpec.describe 'Comments', :type => :system do
  describe 'コメントテスト' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post) }
    describe 'ログイン前' do
      context 'ログインしないとコメントできない' do
        it '投稿ボタンなし', :js => true do
          visit root_path
          click_on 'test store'
          Capybara.exact = true    
          expect(page).to have_no_button '投　稿'
        end
      end
    end
    describe 'ログイン後' do
      describe 'userとしてログイン' do
        before do
          login_as(user)
          visit root_path(:user)
        end
        context 'コメント成功' do
          it 'フォームの入力値が正常', :js => true do
            click_on 'test store'
            expect(page).to have_button '投　稿'
            fill_in "comment_comment_content", :with => "コーヒーがおすすめです！"
            click_button "投　稿"
            expect(page).to have_content 'コメントを作成しました'
            expect(page).to have_content 'コーヒーがおすすめです！'
          end
        end
        context 'コメント失敗' do
          it 'フォームに未記入', :js => true do
            click_on 'test store'
            fill_in "comment_comment_content", :with => nil
            click_button "投　稿"
            expect(page).to have_content 'コメントを作成できませんでした'
          end
        end
        context 'コメント削除' do
          it '自分のコメントを削除（確認ダイアログでOKを選択）', :js => true do
            click_on 'test store'
            fill_in "comment_comment_content", :with => "コーヒーがおすすめです！"
            click_button "投　稿"
            expect(page).to have_content 'コーヒーがおすすめです！'
            expect(page).to have_link '削除'
            # 確認ダイアログでOKを選択
            page.accept_confirm("本当に削除して良いですか？") do
              click_on '削除'
            end
            expect(page).to have_content 'コメントを削除しました。'
            expect(page).to have_no_content 'コーヒーがおすすめです！'
          end
          it '自分のコメントを削除しない（確認ダイアログでキャンセルを選択）', :js => true do
            click_on 'test store'
            fill_in "comment_comment_content", :with => "コーヒーがおすすめです！"
            click_button "投　稿"
            expect(page).to have_content 'コーヒーがおすすめです！'
            expect(page).to have_link '削除'
            # 確認ダイアログでキャンセルを選択
            page.dismiss_confirm("本当に削除して良いですか？") do
              click_on '削除'
            end
            expect(page).to have_content 'コーヒーがおすすめです！'
          end
        end
      end
      describe 'another_userとしてログイン' do
        let!(:comment) { create(:comment) }
        let(:another_user)  { User.create(name: 'maruo', email: 'maruo@example.com', password: 'password') }
        before do
          login_as(another_user)
          visit root_path(another_user)
        end
        context 'コメント削除' do
          it '自分以外のユーザーのコメントは削除できない', :js => true do
            expect(page).to have_content 'test store'
            click_on 'test store', :match => :first
            expect(page).to have_content 'test comment'
            expect(page).to have_no_link '削除'
          end
        end
      end
    end
  end
end