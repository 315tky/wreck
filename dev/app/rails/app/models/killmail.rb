class Killmail < ApplicationRecord
  has_many :killmail_attackers, :primary_key => "killmail_id", :foreign_key => "killmail_id", dependent: :destroy
  has_many :killmail_items, :primary_key => "killmail_id", :foreign_key =>  "killmail_id", dependent: :destroy
  belongs_to :solarsystem, :primary_key => "solar_system_id", :foreign_key => "solar_system_id", :optional => true

  def home_kills(home_corp_id)
    home_kills = []
    self.each do |killmail|
      if killmail.victim_corporation_id != corp_id
        home_kills.push(killmail)
      end
    end
    return home_kills
  end

  def home_losses(home_corp_id)
    home_losses = []
    self.each do |killmail|
      if killmail.victim_corporation_id == corp_id
        home_losses.push(killmail)
      end
    end
    return home_losses
  end
end
