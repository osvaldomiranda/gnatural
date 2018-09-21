class Event < ActiveRecord::Base


  def self.day_name(date)
    day = date.strftime("%A")
    case day
    when "Sunday"
      return 'D'
    when "Monday"
      return 'L'
    when "Tuesday"
      return 'M'
    when "Wednesday"
      return 'M'
    when "Thursday"
      return 'J'
    when "Friday"
      return 'V'
    when "Saturday"
      return 'S'
    else
    end
  end

  COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  def self.days_in_month(month, year)
    return 29 if month == 2 && Date.gregorian_leap?(year)
    COMMON_YEAR_DAYS_IN_MONTH[month]
  end
  
  def self.hours_in_day
    time_start = DateTime.parse('2018-01-01 09:00:00')
    time_end = time_start + 11.hour
    [time_start].tap { |array| array << array.last + 15.minutes while array.last < time_end }
  end

  def self.mes_options_for_select
    (1..12).map{|m| "#{m.to_s.rjust(2, '0')}-#{Date.today.year}"}
  end 


end

