# 実施するファイルにて、以下のようにcustom_helper.rbを読み込む必要があります。
# require 'custom_helper.rb

RSpec.configure do |config|
  config.before(:suite) do
    FactoryBot.definition_file_paths = %w[spec/beginner/station06/factories]
    FactoryBot.find_definitions
  end
end
