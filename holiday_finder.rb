# The wday method returns a number with Sunday = 0 through Saturday = 6

module HolidayCalculator
  require 'date'

  def new_years_day(year)
    Date.new(year,1,1)
  end

  def mlkj_day(year)
    mondays = 0
    result = nil
    (1..31).each do |day|
      date = Date.new(year,1,day)
      mondays += 1 if date.wday == 1
      if mondays == 3
        result = date
        break
      end
    end
    result
  end

  def presidents_day(year)
    mondays = 0
    result = nil
    (1..29).each do |day|
      date = Date.new(year,2,day)
      mondays += 1 if date.wday == 1
      if mondays == 3
        result = date
        break
      end
    end
    result
  end

  def memorial_day(year)
    result = nil
    (1..31).each do |day|
      date = Date.new(year,5,day)
      result = date if date.wday == 1
    end
    result
  end

  def independence_day(year)
    Date.new(2016,7,4)
  end

  def labor_day(year)
    result = nil
    (1..7).each do |day|
      date = Date.new(year,9,day)
      if date.wday == 1
        result = date
        break
      end
    end
    result
  end

  def columbus_day(year)
    result = nil
    mondays = 0
    (1..14).each do |day|
      date = Date.new(year,10,day)
      mondays += 1 if date.wday == 1
      if mondays == 2
        result = date
        break
      end
    end
    result
  end

  def veterans_day(year)
    Date.new(year,11,11)
  end

  def thanksgiving_day(year)
    result = nil
    thursdays = 0
    (1..31).each do |day|
      date = Date.new(year,11,day)
      thursdays += 1 if date.wday == 4
      if thursdays == 4
        result = date
        break
      end
    end
    result
  end

  # I know this isn't a real holiday, but offices often take this day off
  def black_friday(year)
    result = nil
    thursdays = 0
    (1..31).each do |day|
      date = Date.new(year,11,day)
      thursdays += 1 if date.wday == 4
      if thursdays == 4
        result = date + 1
        break
      end
    end
    result
  end

  def christmas_day(year)
    Date.new(year,12,25)
  end

  def holidays(year)
    [
      new_years_day(year),
      mlkj_day(year),
      presidents_day(year),
      memorial_day(year),
      independence_day(year),
      labor_day(year),
      columbus_day(year),
      veterans_day(year),
      thanksgiving_day(year),
      black_friday(year),
      christmas_day(year)
    ]
  end

end

class Date
  include HolidayCalculator

  def is_weekend?
    self.wday == 0 || self.wday == 6 ? true : false
  end

  def is_holiday?
    holidays(self.year).include? self
  end

  def is_workday?
    !self.is_weekend? && !self.is_holiday?
  end
end

# Example usage
=begin
include HolidayCalculator
date1 = Date.today
puts date1.strftime('%a %d %b %Y')
puts "Weekend: #{date1.is_weekend?}"
puts "Holiday: #{date1.is_holiday?}"
puts "Workday: #{date1.is_workday?}"
=end
