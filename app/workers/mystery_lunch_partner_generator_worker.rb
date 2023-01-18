require 'sidekiq-scheduler'

class MysteryLunchPartnerGeneratorWorker
  include Sidekiq::Worker

  def perform
    MysteryMatchGenerator.new.call
  end
end
