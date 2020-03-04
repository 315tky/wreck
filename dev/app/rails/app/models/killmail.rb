class Killmail < ApplicationRecord

  scope :kills, -> { where.not(victim_corporation_id: 98473505) }
  scope :losses, -> { where(victim_corporation_id: 98473505) }

  has_many :killmail_attackers, :primary_key => "killmail_id", :foreign_key => "killmail_id", dependent: :destroy
  has_many :killmail_items, :primary_key => "killmail_id", :foreign_key =>  "killmail_id", dependent: :destroy
  belongs_to :solarsystem, :primary_key => "solar_system_id", :foreign_key => "solar_system_id", :optional => true


  def self.get_by_time(time_frame)
    if time_frame == "all"
      kills_list = self.kills
      top_ten_attackers(kills_list)
    elsif time_frame == "month"
      kills_list = self.kills.where(killmail_time: 1.month.ago..)
      top_ten_attackers(kills_list)
    elsif time_frame == "week"
      kills_list = self.kills.where(killmail_time: 1.week.ago..)
      top_ten_attackers(kills_list)
    end
  end

  def self.top_ten_attackers(kills_list)
    hash = {}
    all_attackers = kills_list.map { |kill| kill.killmail_attackers }
    attackers = all_attackers.map { |attackers| attackers.map { |attacker| attacker.attacker_id } }
    attackers.flatten.compact.tally.sort_by { |k,v| -v }.first(10).each do |attacker|
      hash[Character.where(character_id: attacker[0]).first.name] = attacker[1]
    end
    pp hash
    return hash
  end
end
