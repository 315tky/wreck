class KillmailsController < ApplicationController

  def kills_by_char
    @pagy_kills, @kills_by_char = pagy(KillmailsWithFinalBlowAttacker.kills_by_char(params[:char_name]))
  end

  def losses_by_char
    @pagy_losses, @losses_by_char = pagy(KillmailsWithFinalBlowAttacker.losses_by_char(params[:char_name]))
  end

end
