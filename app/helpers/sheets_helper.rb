module SheetsHelper
  # メソッド
  def render_rows(sheets, row)
    movie_id = params[:id]
    date = params[:date]
    schedule_id = params[:schedule_id]

    sheets.select { |sheet| sheet.row == row }
          .sort_by { |sheet| sheet.column.to_i }
          .map { |sheet| generate_sheet_td(sheet, row, movie_id, date, schedule_id) }
          .join
          .html_safe
  end

  # メソッド(Private)

  private

  def generate_sheet_td(sheet, row, movie_id, date, schedule_id)
    content = "#{row.upcase}-#{sheet.column}"
    if movie_id.present? && date.present? && schedule_id.present?
      content_tag(
        :td,
        link_to(
          content,
          new_movie_reservation_path(movie_id: movie_id, date: date, schedule_id: schedule_id, sheet_id: sheet.id)
        ),
        class: 'highlight'
      )
    else
      content_tag(:td, content)
    end
  end
end
