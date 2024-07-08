class EmailValidator < ActiveModel::EachValidator
  # 定数
  EMAIL_REG = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  # メソッド
  def validate_each(record, attribute, value)
    return if value.blank?
    return if value =~ EMAIL_REG

    record.errors.add(attribute, options[:message] || :invalid)
  end
end
