class UpdateKillmailsWithFinalBlowAttackersToVersion2 < ActiveRecord::Migration[6.0]
  def change
    update_view :killmails_with_final_blow_attackers, version: 2, revert_to_version: 1
  end
end
