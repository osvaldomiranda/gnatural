# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180801020835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "centros", id: false, force: true do |t|
    t.integer "id_centro",      limit: 8,   null: false
    t.integer "id_propietario", limit: 8,   null: false
    t.text    "nombre_centro",              null: false
    t.string  "dir_centro",     limit: 120
    t.string  "sector_centro",  limit: 120
    t.string  "comuna_centro",  limit: 50
    t.string  "rut_centro",     limit: 25
    t.string  "web",            limit: 80
    t.string  "email",          limit: 50
    t.string  "telefonos",      limit: 120
    t.string  "anexo",          limit: 20
    t.string  "plan",           limit: 80
  end

  create_table "centros_prop", id: false, force: true do |t|
    t.integer "id_centro",      limit: 8,  null: false
    t.integer "id_propietario", limit: 8,  null: false
    t.string  "email",          limit: 80
    t.string  "status",         limit: 5
  end

  create_table "comments", force: true do |t|
    t.integer  "center_id"
    t.text     "coment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hora_act", id: false, force: true do |t|
    t.string "hora", limit: 50, null: false
  end

  create_table "owner_centers", force: true do |t|
    t.integer  "user_id"
    t.string   "rut_centro"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_center"
    t.integer  "id_centro"
  end

  add_index "owner_centers", ["user_id"], name: "index_owner_centers_on_user_id", using: :btree

  create_table "pos_order", id: false, force: true do |t|
    t.integer  "id_centro",                   null: false
    t.integer  "id",                          null: false
    t.datetime "create_date"
    t.integer  "sale_journal"
    t.string   "pos_reference",   limit: nil
    t.integer  "write_uid"
    t.integer  "account_move"
    t.datetime "date_order"
    t.integer  "location_id"
    t.integer  "nb_print"
    t.integer  "create_uid"
    t.integer  "user_id"
    t.integer  "partner_id"
    t.integer  "company_id",                  null: false
    t.text     "note"
    t.string   "state",           limit: nil
    t.integer  "pricelist_id",                null: false
    t.datetime "write_date"
    t.string   "name",            limit: nil, null: false
    t.integer  "invoice_id"
    t.integer  "session_id"
    t.integer  "picking_id"
    t.integer  "sequence_number"
    t.string   "customer_email",  limit: nil
  end

  add_index "pos_order", ["date_order"], name: "pos_order_date_order_index", using: :btree
  add_index "pos_order", ["id_centro"], name: "pos_order_id_centro", using: :btree
  add_index "pos_order", ["partner_id"], name: "pos_order_partner_id_index", using: :btree
  add_index "pos_order", ["session_id"], name: "pos_order_session_id_index", using: :btree

  create_table "pos_order_line", id: false, force: true do |t|
    t.integer  "id_centro",                       null: false
    t.integer  "id"
    t.integer  "create_uid"
    t.string   "notice",              limit: nil
    t.datetime "create_date"
    t.string   "name",                limit: nil, null: false
    t.integer  "order_id"
    t.decimal  "price_unit"
    t.decimal  "price_subtotal"
    t.integer  "company_id",                      null: false
    t.decimal  "price_subtotal_incl"
    t.decimal  "qty"
    t.decimal  "discount"
    t.datetime "write_date"
    t.integer  "write_uid"
    t.integer  "product_id",                      null: false
    t.text     "comments"
    t.text     "order_line_note"
  end

  create_table "product_product", id: false, force: true do |t|
    t.integer  "id_centro",                     null: false
    t.integer  "id",                            null: false
    t.string   "ean13",             limit: 13
    t.datetime "create_date"
    t.string   "default_code",      limit: nil
    t.string   "name_template",     limit: nil
    t.integer  "create_uid"
    t.datetime "message_last_post"
    t.integer  "product_tmpl_id",               null: false
    t.binary   "image_variant"
    t.integer  "write_uid"
    t.datetime "write_date"
    t.boolean  "active"
  end

  add_index "product_product", ["default_code"], name: "product_product_default_code_index", using: :btree
  add_index "product_product", ["id_centro"], name: "product_id_centro_index", using: :btree
  add_index "product_product", ["name_template"], name: "product_product_name_template_index", using: :btree
  add_index "product_product", ["product_tmpl_id"], name: "product_product_product_tmpl_id_index", using: :btree

  create_table "propietario", id: false, force: true do |t|
    t.integer "id_propietario",     limit: 8,   null: false
    t.string  "nombre_propietario", limit: 120
    t.string  "rut_propietario",    limit: 15
    t.string  "dir_propietario",    limit: 120
  end

  create_table "res_partner", id: false, force: true do |t|
    t.integer  "id_centro",                            null: false
    t.integer  "id",                                   null: false
    t.string   "name",                     limit: nil, null: false
    t.integer  "company_id"
    t.text     "comment"
    t.string   "ean13",                    limit: 13
    t.datetime "create_date"
    t.integer  "color"
    t.binary   "image_small"
    t.binary   "image"
    t.date     "date"
    t.string   "street",                   limit: nil
    t.string   "city",                     limit: nil
    t.string   "display_name",             limit: nil
    t.string   "zip",                      limit: 24
    t.integer  "title"
    t.string   "function",                 limit: nil
    t.integer  "country_id"
    t.integer  "parent_id"
    t.boolean  "supplier"
    t.string   "ref",                      limit: nil
    t.string   "email",                    limit: nil
    t.boolean  "is_company"
    t.string   "website",                  limit: nil
    t.boolean  "customer"
    t.string   "fax",                      limit: nil
    t.string   "street2",                  limit: nil
    t.boolean  "employee"
    t.float    "credit_limit"
    t.datetime "write_date"
    t.boolean  "active"
    t.string   "tz",                       limit: 64
    t.integer  "write_uid"
    t.string   "lang",                     limit: nil
    t.integer  "create_uid"
    t.binary   "image_medium"
    t.string   "phone",                    limit: nil
    t.string   "mobile",                   limit: nil
    t.string   "type",                     limit: nil
    t.boolean  "use_parent_address"
    t.integer  "user_id"
    t.string   "birthdate",                limit: nil
    t.string   "vat",                      limit: nil
    t.integer  "state_id"
    t.integer  "commercial_partner_id"
    t.string   "notify_email",             limit: nil, null: false
    t.datetime "message_last_post"
    t.boolean  "opt_out"
    t.integer  "section_id"
    t.string   "signup_type",              limit: nil
    t.datetime "signup_expiration"
    t.string   "signup_token",             limit: nil
    t.datetime "calendar_last_notif_ack"
    t.datetime "last_reconciliation_date"
    t.float    "debit_limit"
    t.boolean  "vat_subjected"
    t.boolean  "prefer_ereceipt"
  end

  add_index "res_partner", ["company_id"], name: "res_partner_company_id_index", using: :btree
  add_index "res_partner", ["date"], name: "res_partner_date_index", using: :btree
  add_index "res_partner", ["display_name"], name: "res_partner_display_name_index", using: :btree
  add_index "res_partner", ["id_centro"], name: "res_partner_id_centro_index", using: :btree
  add_index "res_partner", ["name"], name: "res_partner_name_index", using: :btree
  add_index "res_partner", ["parent_id"], name: "res_partner_parent_id_index", using: :btree
  add_index "res_partner", ["ref"], name: "res_partner_ref_index", using: :btree

  create_table "res_users", id: false, force: true do |t|
    t.integer  "id_centro",                                                null: false
    t.integer  "id",                                                       null: false
    t.boolean  "active",                                    default: true
    t.string   "login",                         limit: 64,                 null: false
    t.string   "password",                      limit: nil
    t.integer  "company_id",                                               null: false
    t.integer  "partner_id",                                               null: false
    t.integer  "create_uid"
    t.datetime "create_date"
    t.date     "login_date"
    t.integer  "write_uid"
    t.datetime "write_date"
    t.text     "signature"
    t.integer  "action_id"
    t.string   "password_crypt",                limit: nil
    t.integer  "alias_id",                                                 null: false
    t.boolean  "display_groups_suggestions"
    t.integer  "default_section_id"
    t.boolean  "share"
    t.boolean  "display_employees_suggestions"
    t.string   "ean13",                         limit: 13
    t.integer  "pos_config"
  end

  add_index "res_users", ["id_centro"], name: "res_users_id_centro_index", using: :btree
  add_index "res_users", ["login_date"], name: "res_users_login_date_index", using: :btree

  create_table "tablon2_anual", id: false, force: true do |t|
    t.integer  "id_centro",                     limit: 8,                  null: false
    t.integer  "id_propietario",                limit: 8,                  null: false
    t.text     "nombre_centro",                                            null: false
    t.string   "dir_centro",                    limit: 120
    t.string   "sector_centro",                 limit: 120
    t.string   "comuna_centro",                 limit: 50
    t.string   "rut_centro",                    limit: 25
    t.string   "web",                           limit: 80
    t.string   "email",                         limit: 50
    t.string   "telefonos",                     limit: 120
    t.string   "anexo",                         limit: 20
    t.string   "plan",                          limit: 80
    t.integer  "id_order"
    t.datetime "create_date_order"
    t.integer  "sale_journal"
    t.string   "pos_reference",                 limit: nil
    t.integer  "write_uid_order"
    t.integer  "account_move"
    t.datetime "date_order"
    t.integer  "location_id"
    t.integer  "nb_print"
    t.integer  "create_uid_order"
    t.integer  "user_id_order"
    t.integer  "partner_id_order"
    t.integer  "company_id_order"
    t.text     "note"
    t.string   "state",                         limit: nil
    t.integer  "pricelist_id"
    t.datetime "write_date_order"
    t.string   "name_order",                    limit: nil
    t.integer  "invoice_id"
    t.integer  "session_id"
    t.integer  "picking_id"
    t.integer  "sequence_number"
    t.string   "customer_email",                limit: nil
    t.integer  "id_centro_order_line"
    t.integer  "id_order_line"
    t.integer  "create_uid_order_line"
    t.string   "notice",                        limit: nil
    t.datetime "create_date_order_line"
    t.string   "name_order_line",               limit: nil
    t.integer  "order_id"
    t.decimal  "price_unit"
    t.decimal  "price_subtotal"
    t.integer  "company_id"
    t.decimal  "price_subtotal_incl"
    t.decimal  "qty"
    t.decimal  "discount"
    t.datetime "write_date_order_line"
    t.integer  "write_uid_order_line"
    t.integer  "product_id"
    t.text     "comments"
    t.text     "order_line_note"
    t.integer  "id_product"
    t.string   "ean13_product",                 limit: 13
    t.datetime "create_date_product"
    t.string   "default_code",                  limit: nil
    t.string   "name_template",                 limit: nil
    t.integer  "create_uid_product"
    t.datetime "message_last_post_product"
    t.integer  "product_tmpl_id"
    t.binary   "image_variant"
    t.integer  "write_uid_product"
    t.datetime "write_date_product"
    t.boolean  "active_product"
    t.integer  "id_prop",                       limit: 8
    t.string   "nombre_propietario",            limit: 120
    t.string   "rut_propietario",               limit: 15
    t.string   "dir_propietario",               limit: 120
    t.integer  "id_partner"
    t.string   "name_partner",                  limit: nil
    t.integer  "company_id_partner"
    t.text     "comment"
    t.string   "ean13_partner",                 limit: 13
    t.datetime "create_date_partner"
    t.integer  "color"
    t.binary   "image_small"
    t.binary   "image"
    t.date     "date_partner"
    t.string   "street",                        limit: nil
    t.string   "city",                          limit: nil
    t.string   "display_name",                  limit: nil
    t.string   "zip",                           limit: 24
    t.integer  "title"
    t.string   "function",                      limit: nil
    t.integer  "country_id"
    t.integer  "parent_id"
    t.boolean  "supplier"
    t.string   "ref",                           limit: nil
    t.string   "email_partner",                 limit: nil
    t.boolean  "is_company"
    t.string   "website",                       limit: nil
    t.boolean  "customer"
    t.string   "fax",                           limit: nil
    t.string   "street2",                       limit: nil
    t.boolean  "employee"
    t.float    "credit_limit"
    t.datetime "write_date"
    t.boolean  "active_partner"
    t.string   "tz",                            limit: 64
    t.integer  "write_uid"
    t.string   "lang",                          limit: nil
    t.integer  "create_uid"
    t.binary   "image_medium"
    t.string   "phone",                         limit: nil
    t.string   "mobile",                        limit: nil
    t.string   "type",                          limit: nil
    t.boolean  "use_parent_address"
    t.integer  "user_id"
    t.string   "birthdate",                     limit: nil
    t.string   "vat",                           limit: nil
    t.integer  "state_id"
    t.integer  "commercial_partner_id"
    t.string   "notify_email",                  limit: nil
    t.datetime "message_last_post"
    t.boolean  "opt_out"
    t.integer  "section_id"
    t.string   "signup_type",                   limit: nil
    t.datetime "signup_expiration"
    t.string   "signup_token",                  limit: nil
    t.datetime "calendar_last_notif_ack"
    t.datetime "last_reconciliation_date"
    t.float    "debit_limit"
    t.boolean  "vat_subjected"
    t.boolean  "prefer_ereceipt"
    t.integer  "id_centro_users"
    t.integer  "id_users"
    t.boolean  "active",                                    default: true
    t.string   "login",                         limit: 64
    t.string   "password",                      limit: nil
    t.integer  "company_id_users"
    t.integer  "partner_id"
    t.integer  "create_uid_users"
    t.datetime "create_date_users"
    t.date     "login_date"
    t.integer  "write_uid_users"
    t.datetime "write_date_users"
    t.text     "signature"
    t.integer  "action_id"
    t.string   "password_crypt",                limit: nil
    t.integer  "alias_id"
    t.boolean  "display_groups_suggestions"
    t.integer  "default_section_id"
    t.boolean  "share"
    t.boolean  "display_employees_suggestions"
    t.string   "ean13_users",                   limit: 13
    t.integer  "pos_config"
  end

  create_table "tablon_anual", id: false, force: true do |t|
    t.integer  "id_centro",                     limit: 8,                  null: false
    t.integer  "id_propietario",                limit: 8,                  null: false
    t.text     "nombre_centro",                                            null: false
    t.string   "dir_centro",                    limit: 120
    t.string   "sector_centro",                 limit: 120
    t.string   "comuna_centro",                 limit: 50
    t.string   "rut_centro",                    limit: 25
    t.string   "web",                           limit: 80
    t.string   "email",                         limit: 50
    t.string   "telefonos",                     limit: 120
    t.string   "anexo",                         limit: 20
    t.string   "plan",                          limit: 80
    t.integer  "id_order"
    t.datetime "create_date_order"
    t.integer  "sale_journal"
    t.string   "pos_reference",                 limit: nil
    t.integer  "write_uid_order"
    t.integer  "account_move"
    t.datetime "date_order"
    t.integer  "location_id"
    t.integer  "nb_print"
    t.integer  "create_uid_order"
    t.integer  "user_id_order"
    t.integer  "partner_id_order"
    t.integer  "company_id_order"
    t.text     "note"
    t.string   "state",                         limit: nil
    t.integer  "pricelist_id"
    t.datetime "write_date_order"
    t.string   "name_order",                    limit: nil
    t.integer  "invoice_id"
    t.integer  "session_id"
    t.integer  "picking_id"
    t.integer  "sequence_number"
    t.string   "customer_email",                limit: nil
    t.integer  "id_centro_order_line"
    t.integer  "id_order_line"
    t.integer  "create_uid_order_line"
    t.string   "notice",                        limit: nil
    t.datetime "create_date_order_line"
    t.string   "name_order_line",               limit: nil
    t.integer  "order_id"
    t.decimal  "price_unit"
    t.decimal  "price_subtotal"
    t.integer  "company_id"
    t.decimal  "price_subtotal_incl"
    t.decimal  "qty"
    t.decimal  "discount"
    t.datetime "write_date_order_line"
    t.integer  "write_uid_order_line"
    t.integer  "product_id"
    t.text     "comments"
    t.text     "order_line_note"
    t.integer  "id_product"
    t.string   "ean13_product",                 limit: 13
    t.datetime "create_date_product"
    t.string   "default_code",                  limit: nil
    t.string   "name_template",                 limit: nil
    t.integer  "create_uid_product"
    t.datetime "message_last_post_product"
    t.integer  "product_tmpl_id"
    t.binary   "image_variant"
    t.integer  "write_uid_product"
    t.datetime "write_date_product"
    t.boolean  "active_product"
    t.integer  "id_prop",                       limit: 8
    t.string   "nombre_propietario",            limit: 120
    t.string   "rut_propietario",               limit: 15
    t.string   "dir_propietario",               limit: 120
    t.integer  "id_partner"
    t.string   "name_partner",                  limit: nil
    t.integer  "company_id_partner"
    t.text     "comment"
    t.string   "ean13_partner",                 limit: 13
    t.datetime "create_date_partner"
    t.integer  "color"
    t.binary   "image_small"
    t.binary   "image"
    t.date     "date_partner"
    t.string   "street",                        limit: nil
    t.string   "city",                          limit: nil
    t.string   "display_name",                  limit: nil
    t.string   "zip",                           limit: 24
    t.integer  "title"
    t.string   "function",                      limit: nil
    t.integer  "country_id"
    t.integer  "parent_id"
    t.boolean  "supplier"
    t.string   "ref",                           limit: nil
    t.string   "email_partner",                 limit: nil
    t.boolean  "is_company"
    t.string   "website",                       limit: nil
    t.boolean  "customer"
    t.string   "fax",                           limit: nil
    t.string   "street2",                       limit: nil
    t.boolean  "employee"
    t.float    "credit_limit"
    t.datetime "write_date"
    t.boolean  "active_partner"
    t.string   "tz",                            limit: 64
    t.integer  "write_uid"
    t.string   "lang",                          limit: nil
    t.integer  "create_uid"
    t.binary   "image_medium"
    t.string   "phone",                         limit: nil
    t.string   "mobile",                        limit: nil
    t.string   "type",                          limit: nil
    t.boolean  "use_parent_address"
    t.integer  "user_id"
    t.string   "birthdate",                     limit: nil
    t.string   "vat",                           limit: nil
    t.integer  "state_id"
    t.integer  "commercial_partner_id"
    t.string   "notify_email",                  limit: nil
    t.datetime "message_last_post"
    t.boolean  "opt_out"
    t.integer  "section_id"
    t.string   "signup_type",                   limit: nil
    t.datetime "signup_expiration"
    t.string   "signup_token",                  limit: nil
    t.datetime "calendar_last_notif_ack"
    t.datetime "last_reconciliation_date"
    t.float    "debit_limit"
    t.boolean  "vat_subjected"
    t.boolean  "prefer_ereceipt"
    t.integer  "id_centro_users"
    t.integer  "id_users"
    t.boolean  "active",                                    default: true
    t.string   "login",                         limit: 64
    t.string   "password",                      limit: nil
    t.integer  "company_id_users"
    t.integer  "partner_id"
    t.integer  "create_uid_users"
    t.datetime "create_date_users"
    t.date     "login_date"
    t.integer  "write_uid_users"
    t.datetime "write_date_users"
    t.text     "signature"
    t.integer  "action_id"
    t.string   "password_crypt",                limit: nil
    t.integer  "alias_id"
    t.boolean  "display_groups_suggestions"
    t.integer  "default_section_id"
    t.boolean  "share"
    t.boolean  "display_employees_suggestions"
    t.string   "ean13_users",                   limit: 13
    t.integer  "pos_config"
  end

  create_table "tablon_mes", id: false, force: true do |t|
    t.integer  "id_centro",                     limit: 8,                  null: false
    t.integer  "id_propietario",                limit: 8,                  null: false
    t.text     "nombre_centro",                                            null: false
    t.string   "dir_centro",                    limit: 120
    t.string   "sector_centro",                 limit: 120
    t.string   "comuna_centro",                 limit: 50
    t.string   "rut_centro",                    limit: 25
    t.string   "web",                           limit: 80
    t.string   "email",                         limit: 50
    t.string   "telefonos",                     limit: 120
    t.string   "anexo",                         limit: 20
    t.string   "plan",                          limit: 80
    t.integer  "id_order"
    t.datetime "create_date_order"
    t.integer  "sale_journal"
    t.string   "pos_reference",                 limit: nil
    t.integer  "write_uid_order"
    t.integer  "account_move"
    t.datetime "date_order"
    t.integer  "location_id"
    t.integer  "nb_print"
    t.integer  "create_uid_order"
    t.integer  "user_id_order"
    t.integer  "partner_id_order"
    t.integer  "company_id_order"
    t.text     "note"
    t.string   "state",                         limit: nil
    t.integer  "pricelist_id"
    t.datetime "write_date_order"
    t.string   "name_order",                    limit: nil
    t.integer  "invoice_id"
    t.integer  "session_id"
    t.integer  "picking_id"
    t.integer  "sequence_number"
    t.string   "customer_email",                limit: nil
    t.integer  "id_centro_order_line"
    t.integer  "id_order_line"
    t.integer  "create_uid_order_line"
    t.string   "notice",                        limit: nil
    t.datetime "create_date_order_line"
    t.string   "name_order_line",               limit: nil
    t.integer  "order_id"
    t.decimal  "price_unit"
    t.decimal  "price_subtotal"
    t.integer  "company_id"
    t.decimal  "price_subtotal_incl"
    t.decimal  "qty"
    t.decimal  "discount"
    t.datetime "write_date_order_line"
    t.integer  "write_uid_order_line"
    t.integer  "product_id"
    t.text     "comments"
    t.text     "order_line_note"
    t.integer  "id_product"
    t.string   "ean13_product",                 limit: 13
    t.datetime "create_date_product"
    t.string   "default_code",                  limit: nil
    t.string   "name_template",                 limit: nil
    t.integer  "create_uid_product"
    t.datetime "message_last_post_product"
    t.integer  "product_tmpl_id"
    t.binary   "image_variant"
    t.integer  "write_uid_product"
    t.datetime "write_date_product"
    t.boolean  "active_product"
    t.integer  "id_prop",                       limit: 8
    t.string   "nombre_propietario",            limit: 120
    t.string   "rut_propietario",               limit: 15
    t.string   "dir_propietario",               limit: 120
    t.integer  "id_partner"
    t.string   "name_partner",                  limit: nil
    t.integer  "company_id_partner"
    t.text     "comment"
    t.string   "ean13_partner",                 limit: 13
    t.datetime "create_date_partner"
    t.integer  "color"
    t.binary   "image_small"
    t.binary   "image"
    t.date     "date_partner"
    t.string   "street",                        limit: nil
    t.string   "city",                          limit: nil
    t.string   "display_name",                  limit: nil
    t.string   "zip",                           limit: 24
    t.integer  "title"
    t.string   "function",                      limit: nil
    t.integer  "country_id"
    t.integer  "parent_id"
    t.boolean  "supplier"
    t.string   "ref",                           limit: nil
    t.string   "email_partner",                 limit: nil
    t.boolean  "is_company"
    t.string   "website",                       limit: nil
    t.boolean  "customer"
    t.string   "fax",                           limit: nil
    t.string   "street2",                       limit: nil
    t.boolean  "employee"
    t.float    "credit_limit"
    t.datetime "write_date"
    t.boolean  "active_partner"
    t.string   "tz",                            limit: 64
    t.integer  "write_uid"
    t.string   "lang",                          limit: nil
    t.integer  "create_uid"
    t.binary   "image_medium"
    t.string   "phone",                         limit: nil
    t.string   "mobile",                        limit: nil
    t.string   "type",                          limit: nil
    t.boolean  "use_parent_address"
    t.integer  "user_id"
    t.string   "birthdate",                     limit: nil
    t.string   "vat",                           limit: nil
    t.integer  "state_id"
    t.integer  "commercial_partner_id"
    t.string   "notify_email",                  limit: nil
    t.datetime "message_last_post"
    t.boolean  "opt_out"
    t.integer  "section_id"
    t.string   "signup_type",                   limit: nil
    t.datetime "signup_expiration"
    t.string   "signup_token",                  limit: nil
    t.datetime "calendar_last_notif_ack"
    t.datetime "last_reconciliation_date"
    t.float    "debit_limit"
    t.boolean  "vat_subjected"
    t.boolean  "prefer_ereceipt"
    t.integer  "id_centro_users"
    t.integer  "id_users"
    t.boolean  "active",                                    default: true
    t.string   "login",                         limit: 64
    t.string   "password",                      limit: nil
    t.integer  "company_id_users"
    t.integer  "partner_id"
    t.integer  "create_uid_users"
    t.datetime "create_date_users"
    t.date     "login_date"
    t.integer  "write_uid_users"
    t.datetime "write_date_users"
    t.text     "signature"
    t.integer  "action_id"
    t.string   "password_crypt",                limit: nil
    t.integer  "alias_id"
    t.boolean  "display_groups_suggestions"
    t.integer  "default_section_id"
    t.boolean  "share"
    t.boolean  "display_employees_suggestions"
    t.string   "ean13_users",                   limit: 13
    t.integer  "pos_config"
  end

  create_table "tablon_mes_anterior", id: false, force: true do |t|
    t.integer  "id_centro",                     limit: 8,                  null: false
    t.integer  "id_propietario",                limit: 8,                  null: false
    t.text     "nombre_centro",                                            null: false
    t.string   "dir_centro",                    limit: 120
    t.string   "sector_centro",                 limit: 120
    t.string   "comuna_centro",                 limit: 50
    t.string   "rut_centro",                    limit: 25
    t.string   "web",                           limit: 80
    t.string   "email",                         limit: 50
    t.string   "telefonos",                     limit: 120
    t.string   "anexo",                         limit: 20
    t.string   "plan",                          limit: 80
    t.integer  "id_order"
    t.datetime "create_date_order"
    t.integer  "sale_journal"
    t.string   "pos_reference",                 limit: nil
    t.integer  "write_uid_order"
    t.integer  "account_move"
    t.datetime "date_order"
    t.integer  "location_id"
    t.integer  "nb_print"
    t.integer  "create_uid_order"
    t.integer  "user_id_order"
    t.integer  "partner_id_order"
    t.integer  "company_id_order"
    t.text     "note"
    t.string   "state",                         limit: nil
    t.integer  "pricelist_id"
    t.datetime "write_date_order"
    t.string   "name_order",                    limit: nil
    t.integer  "invoice_id"
    t.integer  "session_id"
    t.integer  "picking_id"
    t.integer  "sequence_number"
    t.string   "customer_email",                limit: nil
    t.integer  "id_centro_order_line"
    t.integer  "id_order_line"
    t.integer  "create_uid_order_line"
    t.string   "notice",                        limit: nil
    t.datetime "create_date_order_line"
    t.string   "name_order_line",               limit: nil
    t.integer  "order_id"
    t.decimal  "price_unit"
    t.decimal  "price_subtotal"
    t.integer  "company_id"
    t.decimal  "price_subtotal_incl"
    t.decimal  "qty"
    t.decimal  "discount"
    t.datetime "write_date_order_line"
    t.integer  "write_uid_order_line"
    t.integer  "product_id"
    t.text     "comments"
    t.text     "order_line_note"
    t.integer  "id_product"
    t.string   "ean13_product",                 limit: 13
    t.datetime "create_date_product"
    t.string   "default_code",                  limit: nil
    t.string   "name_template",                 limit: nil
    t.integer  "create_uid_product"
    t.datetime "message_last_post_product"
    t.integer  "product_tmpl_id"
    t.binary   "image_variant"
    t.integer  "write_uid_product"
    t.datetime "write_date_product"
    t.boolean  "active_product"
    t.integer  "id_prop",                       limit: 8
    t.string   "nombre_propietario",            limit: 120
    t.string   "rut_propietario",               limit: 15
    t.string   "dir_propietario",               limit: 120
    t.integer  "id_partner"
    t.string   "name_partner",                  limit: nil
    t.integer  "company_id_partner"
    t.text     "comment"
    t.string   "ean13_partner",                 limit: 13
    t.datetime "create_date_partner"
    t.integer  "color"
    t.binary   "image_small"
    t.binary   "image"
    t.date     "date_partner"
    t.string   "street",                        limit: nil
    t.string   "city",                          limit: nil
    t.string   "display_name",                  limit: nil
    t.string   "zip",                           limit: 24
    t.integer  "title"
    t.string   "function",                      limit: nil
    t.integer  "country_id"
    t.integer  "parent_id"
    t.boolean  "supplier"
    t.string   "ref",                           limit: nil
    t.string   "email_partner",                 limit: nil
    t.boolean  "is_company"
    t.string   "website",                       limit: nil
    t.boolean  "customer"
    t.string   "fax",                           limit: nil
    t.string   "street2",                       limit: nil
    t.boolean  "employee"
    t.float    "credit_limit"
    t.datetime "write_date"
    t.boolean  "active_partner"
    t.string   "tz",                            limit: 64
    t.integer  "write_uid"
    t.string   "lang",                          limit: nil
    t.integer  "create_uid"
    t.binary   "image_medium"
    t.string   "phone",                         limit: nil
    t.string   "mobile",                        limit: nil
    t.string   "type",                          limit: nil
    t.boolean  "use_parent_address"
    t.integer  "user_id"
    t.string   "birthdate",                     limit: nil
    t.string   "vat",                           limit: nil
    t.integer  "state_id"
    t.integer  "commercial_partner_id"
    t.string   "notify_email",                  limit: nil
    t.datetime "message_last_post"
    t.boolean  "opt_out"
    t.integer  "section_id"
    t.string   "signup_type",                   limit: nil
    t.datetime "signup_expiration"
    t.string   "signup_token",                  limit: nil
    t.datetime "calendar_last_notif_ack"
    t.datetime "last_reconciliation_date"
    t.float    "debit_limit"
    t.boolean  "vat_subjected"
    t.boolean  "prefer_ereceipt"
    t.integer  "id_centro_users"
    t.integer  "id_users"
    t.boolean  "active",                                    default: true
    t.string   "login",                         limit: 64
    t.string   "password",                      limit: nil
    t.integer  "company_id_users"
    t.integer  "partner_id"
    t.integer  "create_uid_users"
    t.datetime "create_date_users"
    t.date     "login_date"
    t.integer  "write_uid_users"
    t.datetime "write_date_users"
    t.text     "signature"
    t.integer  "action_id"
    t.string   "password_crypt",                limit: nil
    t.integer  "alias_id"
    t.boolean  "display_groups_suggestions"
    t.integer  "default_section_id"
    t.boolean  "share"
    t.boolean  "display_employees_suggestions"
    t.string   "ean13_users",                   limit: 13
    t.integer  "pos_config"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "rut"
    t.string   "name"
    t.string   "access_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
