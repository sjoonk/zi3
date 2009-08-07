module EventsHelper
  def days_array(time, fill_blank=false)
    returning [] do |arr|
      0.upto(time.beginning_of_month.wday-1) { arr << nil } if fill_blank
      1.upto(Time.days_in_month(time.month)) { |day| arr << day }
    end.flatten
  end

  def taggings_for(time, day, events=[])
    unless day.nil?
      time = time.change(:day => day)
      class_attrs = []; value = time.day
      class_attrs << 'today' if time.day == Time.today.day
      class_attrs << 'sunday' if time.wday == 0
      event_days = events.map { |event| event.date.day }.uniq
      if event_days.include?(time.day)
        value = link_to_function time.day, "show_event(#{time.day});"
      end
      content_tag :span, value, :class => class_attrs.join(' ')
    end  
  end

end
