namespace :db do
  task reinstall: :environment do
    cmd = 'rm -fr public/uploads/*'
    puts cmd
    `#{cmd}`

    Rake::Task['db:drop'].invoke
    Rake::Task['tmp:create'].invoke
    Rake::Task['tmp:cache:clear'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke unless Rails.env.production?
  end
end
