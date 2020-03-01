class Corporation < ApplicationRecord

require 'swagger_client'

  def self.corporation_import(corporations_ids)

    for_import = []
    corporations_ids.each do |id|
      corp_detail = self.esi_lookup(id)
      import_hash = { "corporation_id"    => id ||= '',
                      "name"              => corp_detail.name ||= '',
                      "alliance_id"       => corp_detail.alliance_id ||= '',
                      "ceo_id"            => corp_detail.ceo_id ||= '',
                      "creator_id"        => corp_detail.creator_id ||= '',
                      "description"       => corp_detail.description ||= '',
                      "home_station_id"   => corp_detail.home_station_id ||= '',
                      "member_count"      => corp_detail.member_count ||= '',
                      "shares"            => corp_detail.shares ||= '',
                      "url"               => corp_detail.url ||= '',
                      "war_eligible"      => corp_detail.war_eligible ||= ''
                     }

       for_import.push(import_hash)
  end
    Corporation.import for_import,
      on_duplicate_key_update: { conflict_target: [:corporation_id, :name],
                                 columns: [:alliance_id,
                                           :ceo_id,
                                           :creator_id,
                                           :description,
                                           :home_station_id,
                                           :member_count,
                                           :shares,
                                           :url,
                                           :war_eligible] }
   end

   def self.esi_lookup(corporation_id)

     api_instance = SwaggerClient::CorporationApi.new
     opts = {
      datasource: 'tranquility', # String | The server name you would like data from
      if_none_match: 'if_none_match_example', # String | ETag from a previous request. A 304 will be returned if this matches the current ETag
    }
    begin
      #Get corporation information
      result = api_instance.get_corporations_corporation_id(corporation_id, opts)
    rescue SwaggerClient::ApiError => e
      puts "Exception when calling CorporationApi->get_corporations_corporation_id: #{e}"
    end
  end
end
