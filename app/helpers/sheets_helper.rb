module SheetsHelper
  def render_rows(sheets, row)
    sheets.select { |sheet| sheet.row == row }
          .sort_by { |sheet| sheet.column.to_i }
          .map { |sheet| content_tag(:td, "#{row.upcase}-#{sheet.column}", class: 'highlight') }
          .join
          .html_safe
  end
end
