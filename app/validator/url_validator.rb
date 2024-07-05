class UrlValidator < ActiveModel::EachValidator
  # 定数
  URL_REG = /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/.freeze

  # メソッド
  def validate_each(record, attribute, value)
    return if value.blank?
    return if value =~ URL_REG
    return if value.length <= 150

    record.errors.add(attribute, options[:message] || :invalid)
  end
end
