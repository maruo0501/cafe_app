require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe 'ログイン前' do
    context 'ログインしないと投稿できない' do
      it '投稿リンクなし' do
        visit root_path
        Capybara.exact = true        
        expect(page).to have_no_link('投稿')
      end
    end
    context 'ログインしなくても投稿一覧はアクセス可能' do
      it '投稿一覧リンクあり' do
        visit root_path
        Capybara.exact = true
        expect(page).to have_link('投稿一覧')
        click_on '投稿一覧'
        expect(current_path).to eq "/posts/index"
      end
    end
  end

  describe 'ログイン後' do
    before do
      @user = User.create(name: 'yamada', email: 'yamada@example.com', password: 'password')
      login_as(@user)
      visit root_path
      Capybara.exact = true
      click_on '投稿'
    end

    context '投稿成功' do
      it 'フォームの入力値が正常' do
        expect(current_path).to eq "/posts/new"
        # デフォルトでボタンがチェックされていることを検証
        expect(page).to have_checked_field 'wifi_yes'
        expect(page).to have_checked_field 'power_yes'
        expect(page).to have_checked_field 'creditcard_yes'
        # 画像、店名、おすすめポイントを入力
        expect {
          attach_file 'image', "#{Rails.root}/spec/cafe01.jpg"
          fill_in 'store_name', with: 'cafe'
          # wifiなしを選択
          choose 'wifi_no'
          # 電源なしを選択
          choose 'power_no'
          # クレジットカード利用不可を選択
          choose 'creditcard_no'
          fill_in 'content', with: 'おすすめです！'
          click_button '投稿'
        }.to change{ Post.count }.by(1)
        expect(current_path).to eq '/posts/index'
        expect(page).to have_content '投稿を作成しました'
        # 正しく投稿されていることを検証
        expect(page).to have_selector("img[src$='cafe01.jpg']")
        expect(page).to have_content 'cafe'
        expect(page).to have_content 'おすすめです！'
      end
    end
    context '投稿失敗' do
      it '店名未記入' do
        attach_file 'image', "#{Rails.root}/spec/cafe01.jpg"
        fill_in 'store_name', with: nil
        # wifiなしを選択
        choose 'wifi_no'
        # 電源なしを選択
        choose 'power_no'
        # クレジットカード利用不可を選択
        choose 'creditcard_no'
        fill_in 'content', with: "おすすめです！"
        click_button '投稿'
        expect(current_path).to eq '/posts/create'
        expect(page).to have_content '店名を入力してください'
      end
    end
    context '投稿編集' do
      it '自分の投稿を編集' do
        fill_in 'store_name', with: 'カフェ'
        fill_in 'content', with: 'コーヒーが美味しいです！'
        click_button '投稿'
        expect(current_path).to eq '/posts/index'
        expect(page).to have_link('カフェ')
        click_link 'カフェ'
        expect(page).to have_link('編集')
        click_link '編集'

        # expect(page).to have_link("#{Rails.root}/spec/default.png")
        # expect(page).to have_selector("img[src$='default.png']")
        expect(page).to have_selector "img[src$='default.png']"
        
        # store_nameに"カフェ"が入力されていることを検証する
        expect(page).to have_field 'post_store_name', with: 'カフェ'
        # contentに"コーヒーが美味しいです！"が入力されていることを検証する
        expect(page).to have_field 'post_content', with: 'コーヒーが美味しいです！'
        # 画像を追加
        # attach_file 'post_image', "#{Rails.root}/spec/cafe01.jpg"
        # 店名を編集
        fill_in 'post_store_name', with: 'コーヒーカフェ'
        click_button '保存'
        expect(current_path).to eq '/posts/index'
        expect(page).to have_content '投稿を編集しました'
        expect(page).to have_content 'コーヒーカフェ'
      end
      it '自分以外のユーザーの投稿は編集できない' do
        @post = FactoryBot.create(:post)
        visit '/posts/index'
        expect(page).to have_link('test store')
        click_link 'test store'
        expect(page).not_to have_link('編集')
      end
    end
    context '投稿削除' do
      it '自分の投稿を削除' do
        fill_in 'store_name', with: 'カフェ'
        fill_in 'content', with: 'コーヒーが美味しいです！'
        click_button '投稿'
        expect(page).to have_link('カフェ')
        click_link 'カフェ'
        expect(page).to have_link('削除')
        click_link '削除'
        expect(current_path).to eq '/posts/index'
        expect(page).to have_content '投稿を削除しました'
      end
      it '自分以外のユーザーの投稿は削除できない' do
        @post = FactoryBot.create(:post)
        visit '/posts/index'
        expect(page).to have_link('test store')
        click_link 'test store'
        expect(page).not_to have_link('削除')
      end
    end
    context 'ユーザー名から投稿一覧が表示される' do
      it '自分の投稿一覧を表示' do
        fill_in 'store_name', with: 'カフェ'
        fill_in 'content', with: 'コーヒーが美味しいです！'
        click_button '投稿'
        click_link 'マイページ'
        expect(page).to have_content 'カフェ'
        expect(page).to have_content 'コーヒーが美味しいです！'
      end
      it '自分以外のユーザーの投稿一覧を表示' do
        user = FactoryBot.create(:user)
        post = FactoryBot.create(:post)
        visit '/posts/index'
        click_link post.user.name
        expect(page).to have_content 'test store'
        expect(page).to have_content 'tester'
        expect(page).not_to have_content 'カフェ'
        expect(page).not_to have_content 'コーヒーが美味しいです！'
      end
    end
  end
end