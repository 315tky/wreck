
require 'esi-get-recent-corp-kills.rb'
require 'download_image.rb'

namespace :eve_import do

  corporation_id = 98473505 # paranoia overload eve corp id

  desc "get_killmails"
  task :killmails => :environment do
    session = ImportKillmail.new
    all_meta_killmails = session.get_corp_killmails_meta(corporation_id)
    for_import = session.check_db(all_meta_killmails)
    all_killmails = session.get_killmail_details(for_import)
    session.import_killmail_details(all_killmails)
  end

  desc "download_character_portraits"
  task :download_portraits => :environment do
     dl = DownloadImage.new
     dl.each_url
  end

  desc "get_characters_from_killmails"
  task :characters => :environment do
    killmails = Killmail.all
    # victims_ids = [2114384643,2113829380,96409737,2114679435,800769548,2113338608,1447318926,91529103,887092880,2112157075,96595223,2114099354,613503643,93279140,762148637,2114497417,96200027,95563504,967403675,2113251020,2112670961,191319464,889377962,96745258,1079073330,979406896,2113701810,93271987,1611508916,96745310,95514422,2114301769,2114417081,92439227,1486297987,92191549,2115594302,2113197377,2114395462,2112213065,180836810,95268683,127738060,96774861,2114854810,133614415,92600145,2114328531,93276117,2112506199,1187877209,1046397274,2115599195,2115033180,2114476382,95090365,674470243,1758928104,2114353769,96222316,96619955,2115070319,2114401904,2113128872,2112182002,97209971,2113842936,96375082]
    victims_ids = killmails.map { |killmail| killmail.victim_id }.compact.uniq
    Character.character_import(victims_ids)

    attackers = KillmailAttacker.all
    attackers_ids = attackers.map { |attacker| attacker.attacker_id }.compact.uniq
    Character.character_import(attackers_ids)
  end

  desc "get_corporations_from_characters"
  task :corporations => :environment do
    characters = Character.all
    corporations_ids = characters.map { |character| character.corporation_id }.compact.uniq
    Corporation.corporation_import(corporations_ids)
  end

  desc "get_alliances_from_corporations"
  task :alliances => :environment do
    alliances_ids = Corporation.all.pluck(:alliance_id).compact.uniq
    Alliance.alliance_import(alliances_ids)
  end

  desc "get_flags_from_local_mysql_import_to_postgres"
  task :flags => :environment do
    Flag.eve_import
  end

  desc "get_dgm_attribute_types_from_local_mysql_import_to_postgres"
  task :dgm_attribute_types => :environment do
    DgmAttributeType.eve_import
  end

# This one is the map between dgm_attributes_types and items :
  desc "get_dgm_type_attribute_from_local_mysql_import_to_postgres"
  task :dgm_type_attributes => :environment do
    DgmTypeAttribute.eve_import
  end

  desc "get_items_from_local_mysql_import_to_postgres"
  task :items => :environment do
    Item.eve_import
  end

  desc "get_regions_from_local_mysql_import_to_postgres"
  task :regions => :environment do
    Region.eve_import
  end

  desc "get_solarsystems_from_local_mysql_import_to_postgres"
  task :solarsystems => :environment do
    Solarsystem.eve_import
  end

  desc "get_constellations_from_local_mysql_import_to_postgres"
  task :constellations => :environment do
    Constellation.eve_import
  end

  desc "run_all_eve_esi_import_tasks"
  task :all_eve_esi => :environment do
    ActiveRecord::Base.transaction do
      tsks = %w[killmails characters corporations alliances]
      tsks.each do |tsk|
	Rake::Task["eve_import:#{tsk}"].invoke
      end
    end
  end

  desc "run_all_eve_mysql_import_tasks"
  task :all_eve_mysql => :environment do
    ActiveRecord::Base.transaction do
      tsks = %w[constellations dgm_attribute_types dgm_type_attributes flags items regions solarsystems ]
      tsks.each do |tsk|
        Rake::Task["eve_import:#{tsk}"].invoke
      end
    end
  end

end
