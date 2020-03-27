class KillmailsWithFinalBlowAttacker < ApplicationRecord

  def self.losses_by_char(char_name)
    where(victim_name: char_name)
  end

  def self.kills_by_char(char_name)
    where(attacker_name: char_name)
  end

end
