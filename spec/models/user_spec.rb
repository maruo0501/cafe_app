require 'rails_helper'

describe User do
  describe '#create' do
    # 入力されている場合のテスト 
    it "全ての項目の入力が存在すれば登録できること" do # テストしたいことの内容
      user = build(:user)  # 変数userにbuildメソッドを使用して、factory_botのダミーデータを代入
      expect(user).to be_valid # 変数userの情報で登録がされるかどうかのテストを実行
    end
    # null:false, presence: true のテスト 
    it "nameがない場合は登録できないこと" do # テストしたいことの内容
      user = build(:user, name: nil) # 変数userにbuildメソッドを使用して、factory_botのダミーデータを代入(今回の場合は意図的にnicknameの値をからに設定)
      user.valid? #バリデーションメソッドを使用して「バリデーションにより保存ができない状態であるか」をテスト
      expect(user.errors[:name]).to include("を入力してください") # errorsメソッドを使用して、「バリデーションにより保存ができない状態である場合なぜできないのか」を確認し、.to include("を入力してください")でエラー文を記述(今回のRailsを日本語化しているのでエラー文も日本語)
    end
    it "emailがない場合は登録できないこと" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
    it "passwordがない場合は登録できないこと" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
    it "encrypted_passwordがない場合は登録できないこと" do
      user = build(:user, encrypted_password: nil)
      user.valid?
      expect(user.errors[:encrypted_password]).to include("を入力してください")
    end
    # email 一意性制約のテスト 
    it "重複したemailが存在する場合登録できないこと" do
      user = create(:user) # createメソッドを使用して変数userとデータベースにfactory_botのダミーデータを保存
      another_user = build(:user, email: user.email) # 2人目のanother_userを変数として作成し、buildメソッドを使用して、意図的にemailの内容を重複させる
      another_user.valid? # another_userの「バリデーションにより保存ができない状態であるか」をテスト
      expect(another_user.errors[:email]).to include("はすでに存在します") # errorsメソッドを使用して、emailの「バリデーションにより保存ができない状態である場合なぜできないのか」を確認し、その原因のエラー文を記述
    end
    # email 小文字化のテスト
    it "emailが大文字の場合登録できないこと" do
      @user = FactoryBot.build(:user)
      @user.email = "TANAKA@example.com"
      @user.save!
      expect(@user.reload.email).to eq "tanaka@example.com"
    end
    # email フォーマットのテスト
    context "無効なEメールを登録しようとした場合" do
      it "emailのvalidateが正しく機能していなければ登録できないこと" do
        address = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com foo@bar..com]
        address.each do |invalid_address|
        expect(build(:user, email: invalid_address)).to be_invalid
        end
      end
    end
    # パスワードと確認用パスワードの一致テスト 
    it "passwordとencrypted_passwordが一致しない場合は登録できないこと" do
      user = build(:user, encrypted_password: "") # 意図的に確認用パスワードに値を空にする
      user.valid?
      expect(user.errors[:encrypted_password]).to include("を入力してください", "は6文字以上で入力してください")
    end
    # パスワードの文字数テスト 
    it "passwordが6文字以上であれば登録できること" do
      user = build(:user, password: "123456", encrypted_password: "123456") # buildメソッドを使用して6文字のパスワードを設定
      expect(user).to be_valid
    end
    it "passwordが5文字以下であれば登録できないこと" do
      user = build(:user, password: "12345", encrypted_password: "12345") # 意図的に5文字のパスワードを設定してエラーが出るかをテスト 
      user.valid?
      expect(user.errors[:encrypted_password]).to include("は6文字以上で入力してください")
    end
  end
  describe "user association" do
    it {have_many :posts}
    it {have_many :favorites}
    it {have_many :comments}
  end
end