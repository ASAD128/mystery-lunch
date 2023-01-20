desc 'First Whenever rake task'
task mystery_partner_generator_task: :environment do
  Rails.logger.info "Task is running..."
  MysteryLunchPartnerGeneratorWorker.perform_in(30.seconds)
end