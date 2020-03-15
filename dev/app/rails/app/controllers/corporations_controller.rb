class CorporationsController < ApplicationController
  def index
    @killmails = Killmail.includes(:killmail_items, :killmail_attackers).order(killmail_time: :desc)

    @kills_last_hour  = Killmail.where(killmail_time: 60.minutes.ago.utc..).kills.count
    @kills_last_day   = Killmail.where(killmail_time: 1.day.ago.utc..).kills.count
    @kills_last_week  = Killmail.where(killmail_time: 1.week.ago.utc..).kills.count
    @kills_last_month = Killmail.where(killmail_time: 1.month.ago..).kills.count
    @kills_aeon = Killmail.kills.count

    @losses_last_hour  = Killmail.where(killmail_time: 60.minutes.ago.utc..).losses.count
    @losses_last_day   = Killmail.where(killmail_time: 1.day.ago.utc..).losses.count
    @losses_last_week  = Killmail.where(killmail_time: 1.week.ago.utc..).losses.count
    @losses_last_month = Killmail.where(killmail_time: 1.month.ago..).losses.count
    @losses_aeon = Killmail.losses.count

    @top_ten_all_time = Killmail.get_by_time("all")
    @top_ten_month    = Killmail.get_by_time("month")
    @top_ten_week     = Killmail.get_by_time("week")
  end

  def show
  end
end
