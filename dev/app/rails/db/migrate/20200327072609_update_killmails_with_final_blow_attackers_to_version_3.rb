class UpdateKillmailsWithFinalBlowAttackersToVersion3 < ActiveRecord::Migration[6.0]
  def change
    update_view :killmails_with_final_blow_attackers, version: 3, revert_to_version: 2
  end
end
