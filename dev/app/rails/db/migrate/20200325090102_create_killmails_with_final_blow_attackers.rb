class CreateKillmailsWithFinalBlowAttackers < ActiveRecord::Migration[6.0]
  def change
    create_view :killmails_with_final_blow_attackers
  end
end
