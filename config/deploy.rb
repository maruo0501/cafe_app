# master.key用のシンボリックリンクを追加
set :linked_files, %w{ config/master.key }

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
 task :restart do
   invoke 'unicorn:restart'
 end

# 以下の記述により、GitHubに記録を残すことなく、master.keyを本番環境内に保存できる。
 desc 'upload master.key'
  task :upload do
   on roles(:app) do |host|
    if test "[ ! -d #{shared_path}/config ]"
      execute "mkdir -p #{shared_path}/config"
    end
      upload!('config/master.key', "#{shared_path}/config/master.key")
    end
  end

  before :starting, 'deploy:upload'
  after :finishing, 'deploy:cleanup'
end