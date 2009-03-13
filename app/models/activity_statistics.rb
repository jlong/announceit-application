class ActivityStatistics
  def initialize(account, teaser)
    @account, @teaser = account, teaser
    start = 7.days.ago.to_date
    @dates = (1..7).collect {|i| start + i.days }
  end
  
  def activity?
    subscribes? || visits?
  end
  
  def xlabels
    @dates.collect {|d| d.strftime('%a') }
  end
  
  def ymax
    highest_value = ([visits.max, subscribes.max].max * 1.10).to_i
    [highest_value, 5].max
  end
  
  def ysteps
    ymax = self.ymax
    [(ymax / 4).to_i, 1].max
  end
  
  def subscribes
    counts = @teaser.subscribes.count(:all,
      :group => 'date(subscribed_on)',
      :conditions => ['subscribed_on in (?)', @dates])
    @dates.collect {|d| counts[d.to_s(:db)] || 0 }
  end
  
  def subscribes?
    subscribes.inject(0) {|sum,c| sum + c} != 0
  end
  
  def visits
    counts = @teaser.visits.count(:all,
      :group => 'date(visited_at)',
      :conditions => ['date(visited_at) in (?)', @dates])
    @dates.collect {|d| counts[d.to_s(:db)] || 0 }
  end
  
  def visits?
    visits.inject(0) {|sum,c| sum + c} != 0
  end
end