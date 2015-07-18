module VersionsHelper
  MARKDOWN = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

  def markdown(text)
    MARKDOWN.render(text).html_safe
  end

  def display_time(time)
    # TODO: if we start supporting timezones then we can have tooltip
    #       with the precise time
    if time.present?
      t = time.to_i
      now = DateTime.current.to_i
      today = DateTime.current.beginning_of_day.to_i
      past_week = (DateTime.current - 1.week).to_i
      age = now - t
      if age < 10
        'just now'
      elsif age < 60
        pluralize age, 'sec'
      elsif age < (60 * 60)
        pluralize age / 60, 'min'
      elsif t >= today
        pluralize age / (60 * 60), 'hr'
      elsif t > past_week
        epoch = Date.new(1970,1,1)
        t_days = (time.to_date - epoch).to_i
        now_days = (DateTime.current.to_date - epoch).to_i
        age_days = now_days - t_days
        pluralize age_days, 'day'
      elsif time.year == DateTime.current.year
        time.strftime('%b %-d').downcase
      else
        time.strftime('%b %-d, %Y').downcase
      end
    end
  end
end
