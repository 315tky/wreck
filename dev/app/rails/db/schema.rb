# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_27_072609) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alliances", force: :cascade do |t|
    t.integer "alliance_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "date_founded"
    t.integer "creator_corporation_id"
    t.integer "creator_id"
    t.integer "executor_corporation_id"
    t.string "ticker"
    t.index ["name", "alliance_id"], name: "index_alliances_on_name_and_alliance_id", unique: true
  end

  create_table "characters", force: :cascade do |t|
    t.integer "character_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "alliance_id"
    t.integer "ancestry_id"
    t.datetime "birthday"
    t.integer "bloodline_id"
    t.integer "corporation_id"
    t.text "description"
    t.string "gender"
    t.integer "race_id"
    t.decimal "security_status"
    t.text "title"
    t.index ["character_id", "name"], name: "index_characters_on_character_id_and_name", unique: true
  end

  create_table "constellations", force: :cascade do |t|
    t.text "constellation_name"
    t.integer "region_id"
    t.integer "constellation_id"
    t.decimal "x_coord"
    t.decimal "y_coord"
    t.decimal "z_coord"
    t.decimal "radius"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["region_id", "constellation_id"], name: "index_constellations_on_region_id_and_constellation_id", unique: true
  end

  create_table "corporations", force: :cascade do |t|
    t.integer "corporation_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "alliance_id"
    t.integer "ceo_id"
    t.integer "creator_id"
    t.datetime "date_founded"
    t.text "description"
    t.integer "home_station_id"
    t.integer "member_count"
    t.string "ticker"
    t.string "url"
    t.boolean "war_eligible"
    t.bigint "shares"
    t.index ["corporation_id", "name"], name: "index_corporations_on_corporation_id_and_name", unique: true
  end

  create_table "dgm_attribute_types", force: :cascade do |t|
    t.integer "attribute_id"
    t.text "attribute_name"
    t.text "description"
    t.integer "icon_id"
    t.integer "published"
    t.text "display_name"
    t.integer "unit_id"
    t.integer "stackable"
    t.integer "high_is_good"
    t.integer "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "default_value"
    t.index ["attribute_id"], name: "index_dgm_attribute_types_on_attribute_id", unique: true
  end

  create_table "dgm_type_attributes", force: :cascade do |t|
    t.integer "item_type_id"
    t.integer "attribute_id"
    t.integer "value_int"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "value_float"
    t.index ["item_type_id", "attribute_id"], name: "index_dgm_type_attributes_on_item_type_id_and_attribute_id", unique: true
  end

  create_table "flags", force: :cascade do |t|
    t.integer "flag_id"
    t.text "flag_name"
    t.text "flag_text"
    t.integer "order_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flag_id"], name: "index_flags_on_flag_id", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.integer "item_type_id"
    t.integer "group_id"
    t.text "type_name"
    t.text "description"
    t.decimal "mass"
    t.decimal "volume"
    t.decimal "capacity"
    t.integer "portion_size"
    t.integer "race_id"
    t.decimal "base_price"
    t.integer "published"
    t.integer "market_group_id"
    t.integer "icon_id"
    t.integer "sound_id"
    t.integer "graphic_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_type_id"], name: "index_items_on_item_type_id", unique: true
  end

  create_table "killmail_attackers", force: :cascade do |t|
    t.integer "killmail_id"
    t.integer "attacker_id"
    t.integer "corporation_id"
    t.integer "alliance_id"
    t.integer "damage_done"
    t.boolean "final_blow"
    t.integer "security_status"
    t.integer "ship_type_id"
    t.integer "weapon_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["killmail_id", "attacker_id"], name: "index_killmail_attackers_on_killmail_id_and_attacker_id", unique: true
  end

  create_table "killmail_items", force: :cascade do |t|
    t.integer "killmail_id"
    t.string "item_type_id"
    t.integer "flag_id"
    t.integer "quantity_destroyed"
    t.integer "quantity_dropped"
    t.integer "singleton"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flag_id", "item_type_id", "killmail_id", "quantity_destroyed", "quantity_dropped"], name: "killmail_item_unique_index", unique: true
  end

  create_table "killmails", force: :cascade do |t|
    t.integer "killmail_id"
    t.datetime "killmail_time"
    t.integer "solar_system_id"
    t.integer "victim_corporation_id"
    t.integer "victim_damage_taken"
    t.jsonb "victim_position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "victim_id"
    t.integer "victim_ship_id"
    t.index ["killmail_id"], name: "index_killmails_on_killmail_id", unique: true
  end

  create_table "regions", force: :cascade do |t|
    t.text "region_name"
    t.integer "region_id"
    t.decimal "x_coord"
    t.decimal "y_coord"
    t.decimal "z_coord"
    t.decimal "radius"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["region_id"], name: "index_regions_on_region_id", unique: true
  end

  create_table "solarsystems", force: :cascade do |t|
    t.integer "solar_system_id"
    t.text "system_name"
    t.integer "sun_type_id"
    t.decimal "security"
    t.text "security_class"
    t.integer "region_id"
    t.integer "constellation_id"
    t.decimal "x_coord"
    t.decimal "y_coord"
    t.decimal "z_coord"
    t.decimal "radius"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["solar_system_id"], name: "index_solarsystems_on_solar_system_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.boolean "login_status"
    t.string "eve_sso_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end


  create_view "killmails_with_final_blow_attackers", sql_definition: <<-SQL
      SELECT killmails.killmail_time,
      solarsystems.system_name AS solar_system,
      characters.name AS victim_name,
      corporations.name AS victims_corporation,
      corporations.corporation_id AS victims_corporation_id,
      alliances.name AS victims_alliance,
      items.type_name AS victim_ship_name,
      killmails.victim_damage_taken,
      attackers.final_blow,
      attackers.attacker_name,
      attackers.attacker_ship_name AS attacker_ship,
      attackers.damage_done,
      attackers.attackers_corporation,
      attackers.attackers_alliance
     FROM ((((((killmails
       LEFT JOIN ( SELECT killmail_attackers.final_blow,
              killmail_attackers.damage_done,
              killmail_attackers.killmail_id,
              characters_1.name AS attacker_name,
              corporations_1.name AS attackers_corporation,
              corporations_1.corporation_id AS attacker_corporation_id,
              alliances_1.name AS attackers_alliance,
              items_1.type_name AS attacker_ship_name
             FROM ((((killmail_attackers
               LEFT JOIN characters characters_1 ON ((killmail_attackers.attacker_id = characters_1.character_id)))
               LEFT JOIN corporations corporations_1 ON ((killmail_attackers.corporation_id = corporations_1.corporation_id)))
               LEFT JOIN alliances alliances_1 ON ((killmail_attackers.alliance_id = alliances_1.alliance_id)))
               LEFT JOIN items items_1 ON ((killmail_attackers.ship_type_id = items_1.item_type_id)))
            WHERE (killmail_attackers.final_blow IS TRUE)) attackers ON ((killmails.killmail_id = attackers.killmail_id)))
       LEFT JOIN characters ON ((killmails.victim_id = characters.character_id)))
       LEFT JOIN corporations ON ((killmails.victim_corporation_id = corporations.corporation_id)))
       LEFT JOIN alliances ON ((corporations.alliance_id = alliances.alliance_id)))
       LEFT JOIN solarsystems ON ((killmails.solar_system_id = solarsystems.solar_system_id)))
       LEFT JOIN items ON ((killmails.victim_ship_id = items.item_type_id)));
  SQL
end
