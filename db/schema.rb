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

ActiveRecord::Schema.define(version: 20180615183113) do

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

  create_table "owner_centers", force: true do |t|
    t.integer  "user_id"
    t.string   "rut_centro"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_center"
  end

  add_index "owner_centers", ["user_id"], name: "index_owner_centers_on_user_id", using: :btree

  create_table "pos_order", id: false, force: true do |t|
    t.integer   "id_centro",                                 null: false
    t.integer   "id",                                        null: false
    t.timestamp "create_date",                 precision: 6
    t.integer   "sale_journal"
    t.string    "pos_reference",   limit: nil
    t.integer   "write_uid"
    t.integer   "account_move"
    t.timestamp "date_order",                  precision: 6
    t.integer   "location_id"
    t.integer   "nb_print"
    t.integer   "create_uid"
    t.integer   "user_id"
    t.integer   "partner_id"
    t.integer   "company_id",                                null: false
    t.text      "note"
    t.string    "state",           limit: nil
    t.integer   "pricelist_id",                              null: false
    t.timestamp "write_date",                  precision: 6
    t.string    "name",            limit: nil,               null: false
    t.integer   "invoice_id"
    t.integer   "session_id"
    t.integer   "picking_id"
    t.integer   "sequence_number"
    t.string    "customer_email",  limit: nil
  end

  create_table "pos_order_line", id: false, force: true do |t|
    t.integer   "id_centro",                                     null: false
    t.integer   "id"
    t.integer   "create_uid"
    t.string    "notice",              limit: nil
    t.timestamp "create_date",                     precision: 6
    t.string    "name",                limit: nil,               null: false
    t.integer   "order_id"
    t.decimal   "price_unit"
    t.decimal   "price_subtotal"
    t.integer   "company_id",                                    null: false
    t.decimal   "price_subtotal_incl"
    t.decimal   "qty"
    t.decimal   "discount"
    t.timestamp "write_date",                      precision: 6
    t.integer   "write_uid"
    t.integer   "product_id",                                    null: false
    t.text      "comments"
    t.text      "order_line_note"
  end

  create_table "product_product", id: false, force: true do |t|
    t.integer   "id_centro",                                   null: false
    t.integer   "id",                                          null: false
    t.string    "ean13",             limit: 13
    t.timestamp "create_date",                   precision: 6
    t.string    "default_code",      limit: nil
    t.string    "name_template",     limit: nil
    t.integer   "create_uid"
    t.timestamp "message_last_post",             precision: 6
    t.integer   "product_tmpl_id",                             null: false
    t.binary    "image_variant"
    t.integer   "write_uid"
    t.timestamp "write_date",                    precision: 6
    t.boolean   "active"
  end

  create_table "propietario", id: false, force: true do |t|
    t.integer "id_propietario",     limit: 8,   null: false
    t.string  "nombre_propietario", limit: 120
    t.string  "rut_propietario",    limit: 15
    t.string  "dir_propietario",    limit: 120
  end

  create_table "res_partner", id: false, force: true do |t|
    t.integer   "id_centro",                                          null: false
    t.integer   "id",                                                 null: false
    t.string    "name",                     limit: nil,               null: false
    t.integer   "company_id"
    t.text      "comment"
    t.string    "ean13",                    limit: 13
    t.timestamp "create_date",                          precision: 6
    t.integer   "color"
    t.binary    "image_small"
    t.binary    "image"
    t.date      "date"
    t.string    "street",                   limit: nil
    t.string    "city",                     limit: nil
    t.string    "display_name",             limit: nil
    t.string    "zip",                      limit: 24
    t.integer   "title"
    t.string    "function",                 limit: nil
    t.integer   "country_id"
    t.integer   "parent_id"
    t.boolean   "supplier"
    t.string    "ref",                      limit: nil
    t.string    "email",                    limit: nil
    t.boolean   "is_company"
    t.string    "website",                  limit: nil
    t.boolean   "customer"
    t.string    "fax",                      limit: nil
    t.string    "street2",                  limit: nil
    t.boolean   "employee"
    t.float     "credit_limit"
    t.timestamp "write_date",                           precision: 6
    t.boolean   "active"
    t.string    "tz",                       limit: 64
    t.integer   "write_uid"
    t.string    "lang",                     limit: nil
    t.integer   "create_uid"
    t.binary    "image_medium"
    t.string    "phone",                    limit: nil
    t.string    "mobile",                   limit: nil
    t.string    "type",                     limit: nil
    t.boolean   "use_parent_address"
    t.integer   "user_id"
    t.string    "birthdate",                limit: nil
    t.string    "vat",                      limit: nil
    t.integer   "state_id"
    t.integer   "commercial_partner_id"
    t.string    "notify_email",             limit: nil,               null: false
    t.timestamp "message_last_post",                    precision: 6
    t.boolean   "opt_out"
    t.integer   "section_id"
    t.string    "signup_type",              limit: nil
    t.timestamp "signup_expiration",                    precision: 6
    t.string    "signup_token",             limit: nil
    t.timestamp "calendar_last_notif_ack",              precision: 6
    t.timestamp "last_reconciliation_date",             precision: 6
    t.float     "debit_limit"
    t.boolean   "vat_subjected"
    t.boolean   "prefer_ereceipt"
  end

  create_table "res_users", id: false, force: true do |t|
    t.integer   "id_centro",                                                              null: false
    t.integer   "id",                                                                     null: false
    t.boolean   "active",                                                  default: true
    t.string    "login",                         limit: 64,                               null: false
    t.string    "password",                      limit: nil
    t.integer   "company_id",                                                             null: false
    t.integer   "partner_id",                                                             null: false
    t.integer   "create_uid"
    t.timestamp "create_date",                               precision: 6
    t.date      "login_date"
    t.integer   "write_uid"
    t.timestamp "write_date",                                precision: 6
    t.text      "signature"
    t.integer   "action_id"
    t.string    "password_crypt",                limit: nil
    t.integer   "alias_id",                                                               null: false
    t.boolean   "display_groups_suggestions"
    t.integer   "default_section_id"
    t.boolean   "share"
    t.boolean   "display_employees_suggestions"
    t.string    "ean13",                         limit: 13
    t.integer   "pos_config"
  end

  create_table "tablon2_anual", id: false, force: true do |t|
    t.integer   "id_centro",                     limit: 8,                                null: false
    t.integer   "id_propietario",                limit: 8,                                null: false
    t.text      "nombre_centro",                                                          null: false
    t.string    "dir_centro",                    limit: 120
    t.string    "sector_centro",                 limit: 120
    t.string    "comuna_centro",                 limit: 50
    t.string    "rut_centro",                    limit: 25
    t.string    "web",                           limit: 80
    t.string    "email",                         limit: 50
    t.string    "telefonos",                     limit: 120
    t.string    "anexo",                         limit: 20
    t.string    "plan",                          limit: 80
    t.integer   "id_order"
    t.timestamp "create_date_order",                         precision: 6
    t.integer   "sale_journal"
    t.string    "pos_reference",                 limit: nil
    t.integer   "write_uid_order"
    t.integer   "account_move"
    t.timestamp "date_order",                                precision: 6
    t.integer   "location_id"
    t.integer   "nb_print"
    t.integer   "create_uid_order"
    t.integer   "user_id_order"
    t.integer   "partner_id_order"
    t.integer   "company_id_order"
    t.text      "note"
    t.string    "state",                         limit: nil
    t.integer   "pricelist_id"
    t.timestamp "write_date_order",                          precision: 6
    t.string    "name_order",                    limit: nil
    t.integer   "invoice_id"
    t.integer   "session_id"
    t.integer   "picking_id"
    t.integer   "sequence_number"
    t.string    "customer_email",                limit: nil
    t.integer   "id_centro_order_line"
    t.integer   "id_order_line"
    t.integer   "create_uid_order_line"
    t.string    "notice",                        limit: nil
    t.timestamp "create_date_order_line",                    precision: 6
    t.string    "name_order_line",               limit: nil
    t.integer   "order_id"
    t.decimal   "price_unit"
    t.decimal   "price_subtotal"
    t.integer   "company_id"
    t.decimal   "price_subtotal_incl"
    t.decimal   "qty"
    t.decimal   "discount"
    t.timestamp "write_date_order_line",                     precision: 6
    t.integer   "write_uid_order_line"
    t.integer   "product_id"
    t.text      "comments"
    t.text      "order_line_note"
    t.integer   "id_product"
    t.string    "ean13_product",                 limit: 13
    t.timestamp "create_date_product",                       precision: 6
    t.string    "default_code",                  limit: nil
    t.string    "name_template",                 limit: nil
    t.integer   "create_uid_product"
    t.timestamp "message_last_post_product",                 precision: 6
    t.integer   "product_tmpl_id"
    t.binary    "image_variant"
    t.integer   "write_uid_product"
    t.timestamp "write_date_product",                        precision: 6
    t.boolean   "active_product"
    t.integer   "id_prop",                       limit: 8
    t.string    "nombre_propietario",            limit: 120
    t.string    "rut_propietario",               limit: 15
    t.string    "dir_propietario",               limit: 120
    t.integer   "id_partner"
    t.string    "name_partner",                  limit: nil
    t.integer   "company_id_partner"
    t.text      "comment"
    t.string    "ean13_partner",                 limit: 13
    t.timestamp "create_date_partner",                       precision: 6
    t.integer   "color"
    t.binary    "image_small"
    t.binary    "image"
    t.date      "date_partner"
    t.string    "street",                        limit: nil
    t.string    "city",                          limit: nil
    t.string    "display_name",                  limit: nil
    t.string    "zip",                           limit: 24
    t.integer   "title"
    t.string    "function",                      limit: nil
    t.integer   "country_id"
    t.integer   "parent_id"
    t.boolean   "supplier"
    t.string    "ref",                           limit: nil
    t.string    "email_partner",                 limit: nil
    t.boolean   "is_company"
    t.string    "website",                       limit: nil
    t.boolean   "customer"
    t.string    "fax",                           limit: nil
    t.string    "street2",                       limit: nil
    t.boolean   "employee"
    t.float     "credit_limit"
    t.timestamp "write_date",                                precision: 6
    t.boolean   "active_partner"
    t.string    "tz",                            limit: 64
    t.integer   "write_uid"
    t.string    "lang",                          limit: nil
    t.integer   "create_uid"
    t.binary    "image_medium"
    t.string    "phone",                         limit: nil
    t.string    "mobile",                        limit: nil
    t.string    "type",                          limit: nil
    t.boolean   "use_parent_address"
    t.integer   "user_id"
    t.string    "birthdate",                     limit: nil
    t.string    "vat",                           limit: nil
    t.integer   "state_id"
    t.integer   "commercial_partner_id"
    t.string    "notify_email",                  limit: nil
    t.timestamp "message_last_post",                         precision: 6
    t.boolean   "opt_out"
    t.integer   "section_id"
    t.string    "signup_type",                   limit: nil
    t.timestamp "signup_expiration",                         precision: 6
    t.string    "signup_token",                  limit: nil
    t.timestamp "calendar_last_notif_ack",                   precision: 6
    t.timestamp "last_reconciliation_date",                  precision: 6
    t.float     "debit_limit"
    t.boolean   "vat_subjected"
    t.boolean   "prefer_ereceipt"
    t.integer   "id_centro_users"
    t.integer   "id_users"
    t.boolean   "active",                                                  default: true
    t.string    "login",                         limit: 64
    t.string    "password",                      limit: nil
    t.integer   "company_id_users"
    t.integer   "partner_id"
    t.integer   "create_uid_users"
    t.timestamp "create_date_users",                         precision: 6
    t.date      "login_date"
    t.integer   "write_uid_users"
    t.timestamp "write_date_users",                          precision: 6
    t.text      "signature"
    t.integer   "action_id"
    t.string    "password_crypt",                limit: nil
    t.integer   "alias_id"
    t.boolean   "display_groups_suggestions"
    t.integer   "default_section_id"
    t.boolean   "share"
    t.boolean   "display_employees_suggestions"
    t.string    "ean13_users",                   limit: 13
    t.integer   "pos_config"
  end

  create_table "tablon_anual", id: false, force: true do |t|
    t.integer   "id_centro",                     limit: 8,                                null: false
    t.integer   "id_propietario",                limit: 8,                                null: false
    t.text      "nombre_centro",                                                          null: false
    t.string    "dir_centro",                    limit: 120
    t.string    "sector_centro",                 limit: 120
    t.string    "comuna_centro",                 limit: 50
    t.string    "rut_centro",                    limit: 25
    t.string    "web",                           limit: 80
    t.string    "email",                         limit: 50
    t.string    "telefonos",                     limit: 120
    t.string    "anexo",                         limit: 20
    t.string    "plan",                          limit: 80
    t.integer   "id_order"
    t.timestamp "create_date_order",                         precision: 6
    t.integer   "sale_journal"
    t.string    "pos_reference",                 limit: nil
    t.integer   "write_uid_order"
    t.integer   "account_move"
    t.timestamp "date_order",                                precision: 6
    t.integer   "location_id"
    t.integer   "nb_print"
    t.integer   "create_uid_order"
    t.integer   "user_id_order"
    t.integer   "partner_id_order"
    t.integer   "company_id_order"
    t.text      "note"
    t.string    "state",                         limit: nil
    t.integer   "pricelist_id"
    t.timestamp "write_date_order",                          precision: 6
    t.string    "name_order",                    limit: nil
    t.integer   "invoice_id"
    t.integer   "session_id"
    t.integer   "picking_id"
    t.integer   "sequence_number"
    t.string    "customer_email",                limit: nil
    t.integer   "id_centro_order_line"
    t.integer   "id_order_line"
    t.integer   "create_uid_order_line"
    t.string    "notice",                        limit: nil
    t.timestamp "create_date_order_line",                    precision: 6
    t.string    "name_order_line",               limit: nil
    t.integer   "order_id"
    t.decimal   "price_unit"
    t.decimal   "price_subtotal"
    t.integer   "company_id"
    t.decimal   "price_subtotal_incl"
    t.decimal   "qty"
    t.decimal   "discount"
    t.timestamp "write_date_order_line",                     precision: 6
    t.integer   "write_uid_order_line"
    t.integer   "product_id"
    t.text      "comments"
    t.text      "order_line_note"
    t.integer   "id_product"
    t.string    "ean13_product",                 limit: 13
    t.timestamp "create_date_product",                       precision: 6
    t.string    "default_code",                  limit: nil
    t.string    "name_template",                 limit: nil
    t.integer   "create_uid_product"
    t.timestamp "message_last_post_product",                 precision: 6
    t.integer   "product_tmpl_id"
    t.binary    "image_variant"
    t.integer   "write_uid_product"
    t.timestamp "write_date_product",                        precision: 6
    t.boolean   "active_product"
    t.integer   "id_prop",                       limit: 8
    t.string    "nombre_propietario",            limit: 120
    t.string    "rut_propietario",               limit: 15
    t.string    "dir_propietario",               limit: 120
    t.integer   "id_partner"
    t.string    "name_partner",                  limit: nil
    t.integer   "company_id_partner"
    t.text      "comment"
    t.string    "ean13_partner",                 limit: 13
    t.timestamp "create_date_partner",                       precision: 6
    t.integer   "color"
    t.binary    "image_small"
    t.binary    "image"
    t.date      "date_partner"
    t.string    "street",                        limit: nil
    t.string    "city",                          limit: nil
    t.string    "display_name",                  limit: nil
    t.string    "zip",                           limit: 24
    t.integer   "title"
    t.string    "function",                      limit: nil
    t.integer   "country_id"
    t.integer   "parent_id"
    t.boolean   "supplier"
    t.string    "ref",                           limit: nil
    t.string    "email_partner",                 limit: nil
    t.boolean   "is_company"
    t.string    "website",                       limit: nil
    t.boolean   "customer"
    t.string    "fax",                           limit: nil
    t.string    "street2",                       limit: nil
    t.boolean   "employee"
    t.float     "credit_limit"
    t.timestamp "write_date",                                precision: 6
    t.boolean   "active_partner"
    t.string    "tz",                            limit: 64
    t.integer   "write_uid"
    t.string    "lang",                          limit: nil
    t.integer   "create_uid"
    t.binary    "image_medium"
    t.string    "phone",                         limit: nil
    t.string    "mobile",                        limit: nil
    t.string    "type",                          limit: nil
    t.boolean   "use_parent_address"
    t.integer   "user_id"
    t.string    "birthdate",                     limit: nil
    t.string    "vat",                           limit: nil
    t.integer   "state_id"
    t.integer   "commercial_partner_id"
    t.string    "notify_email",                  limit: nil
    t.timestamp "message_last_post",                         precision: 6
    t.boolean   "opt_out"
    t.integer   "section_id"
    t.string    "signup_type",                   limit: nil
    t.timestamp "signup_expiration",                         precision: 6
    t.string    "signup_token",                  limit: nil
    t.timestamp "calendar_last_notif_ack",                   precision: 6
    t.timestamp "last_reconciliation_date",                  precision: 6
    t.float     "debit_limit"
    t.boolean   "vat_subjected"
    t.boolean   "prefer_ereceipt"
    t.integer   "id_centro_users"
    t.integer   "id_users"
    t.boolean   "active",                                                  default: true
    t.string    "login",                         limit: 64
    t.string    "password",                      limit: nil
    t.integer   "company_id_users"
    t.integer   "partner_id"
    t.integer   "create_uid_users"
    t.timestamp "create_date_users",                         precision: 6
    t.date      "login_date"
    t.integer   "write_uid_users"
    t.timestamp "write_date_users",                          precision: 6
    t.text      "signature"
    t.integer   "action_id"
    t.string    "password_crypt",                limit: nil
    t.integer   "alias_id"
    t.boolean   "display_groups_suggestions"
    t.integer   "default_section_id"
    t.boolean   "share"
    t.boolean   "display_employees_suggestions"
    t.string    "ean13_users",                   limit: 13
    t.integer   "pos_config"
  end

  create_table "tablon_mes", id: false, force: true do |t|
    t.integer   "id_centro",                     limit: 8,                                null: false
    t.integer   "id_propietario",                limit: 8,                                null: false
    t.text      "nombre_centro",                                                          null: false
    t.string    "dir_centro",                    limit: 120
    t.string    "sector_centro",                 limit: 120
    t.string    "comuna_centro",                 limit: 50
    t.string    "rut_centro",                    limit: 25
    t.string    "web",                           limit: 80
    t.string    "email",                         limit: 50
    t.string    "telefonos",                     limit: 120
    t.string    "anexo",                         limit: 20
    t.string    "plan",                          limit: 80
    t.integer   "id_order"
    t.timestamp "create_date_order",                         precision: 6
    t.integer   "sale_journal"
    t.string    "pos_reference",                 limit: nil
    t.integer   "write_uid_order"
    t.integer   "account_move"
    t.timestamp "date_order",                                precision: 6
    t.integer   "location_id"
    t.integer   "nb_print"
    t.integer   "create_uid_order"
    t.integer   "user_id_order"
    t.integer   "partner_id_order"
    t.integer   "company_id_order"
    t.text      "note"
    t.string    "state",                         limit: nil
    t.integer   "pricelist_id"
    t.timestamp "write_date_order",                          precision: 6
    t.string    "name_order",                    limit: nil
    t.integer   "invoice_id"
    t.integer   "session_id"
    t.integer   "picking_id"
    t.integer   "sequence_number"
    t.string    "customer_email",                limit: nil
    t.integer   "id_centro_order_line"
    t.integer   "id_order_line"
    t.integer   "create_uid_order_line"
    t.string    "notice",                        limit: nil
    t.timestamp "create_date_order_line",                    precision: 6
    t.string    "name_order_line",               limit: nil
    t.integer   "order_id"
    t.decimal   "price_unit"
    t.decimal   "price_subtotal"
    t.integer   "company_id"
    t.decimal   "price_subtotal_incl"
    t.decimal   "qty"
    t.decimal   "discount"
    t.timestamp "write_date_order_line",                     precision: 6
    t.integer   "write_uid_order_line"
    t.integer   "product_id"
    t.text      "comments"
    t.text      "order_line_note"
    t.integer   "id_product"
    t.string    "ean13_product",                 limit: 13
    t.timestamp "create_date_product",                       precision: 6
    t.string    "default_code",                  limit: nil
    t.string    "name_template",                 limit: nil
    t.integer   "create_uid_product"
    t.timestamp "message_last_post_product",                 precision: 6
    t.integer   "product_tmpl_id"
    t.binary    "image_variant"
    t.integer   "write_uid_product"
    t.timestamp "write_date_product",                        precision: 6
    t.boolean   "active_product"
    t.integer   "id_prop",                       limit: 8
    t.string    "nombre_propietario",            limit: 120
    t.string    "rut_propietario",               limit: 15
    t.string    "dir_propietario",               limit: 120
    t.integer   "id_partner"
    t.string    "name_partner",                  limit: nil
    t.integer   "company_id_partner"
    t.text      "comment"
    t.string    "ean13_partner",                 limit: 13
    t.timestamp "create_date_partner",                       precision: 6
    t.integer   "color"
    t.binary    "image_small"
    t.binary    "image"
    t.date      "date_partner"
    t.string    "street",                        limit: nil
    t.string    "city",                          limit: nil
    t.string    "display_name",                  limit: nil
    t.string    "zip",                           limit: 24
    t.integer   "title"
    t.string    "function",                      limit: nil
    t.integer   "country_id"
    t.integer   "parent_id"
    t.boolean   "supplier"
    t.string    "ref",                           limit: nil
    t.string    "email_partner",                 limit: nil
    t.boolean   "is_company"
    t.string    "website",                       limit: nil
    t.boolean   "customer"
    t.string    "fax",                           limit: nil
    t.string    "street2",                       limit: nil
    t.boolean   "employee"
    t.float     "credit_limit"
    t.timestamp "write_date",                                precision: 6
    t.boolean   "active_partner"
    t.string    "tz",                            limit: 64
    t.integer   "write_uid"
    t.string    "lang",                          limit: nil
    t.integer   "create_uid"
    t.binary    "image_medium"
    t.string    "phone",                         limit: nil
    t.string    "mobile",                        limit: nil
    t.string    "type",                          limit: nil
    t.boolean   "use_parent_address"
    t.integer   "user_id"
    t.string    "birthdate",                     limit: nil
    t.string    "vat",                           limit: nil
    t.integer   "state_id"
    t.integer   "commercial_partner_id"
    t.string    "notify_email",                  limit: nil
    t.timestamp "message_last_post",                         precision: 6
    t.boolean   "opt_out"
    t.integer   "section_id"
    t.string    "signup_type",                   limit: nil
    t.timestamp "signup_expiration",                         precision: 6
    t.string    "signup_token",                  limit: nil
    t.timestamp "calendar_last_notif_ack",                   precision: 6
    t.timestamp "last_reconciliation_date",                  precision: 6
    t.float     "debit_limit"
    t.boolean   "vat_subjected"
    t.boolean   "prefer_ereceipt"
    t.integer   "id_centro_users"
    t.integer   "id_users"
    t.boolean   "active",                                                  default: true
    t.string    "login",                         limit: 64
    t.string    "password",                      limit: nil
    t.integer   "company_id_users"
    t.integer   "partner_id"
    t.integer   "create_uid_users"
    t.timestamp "create_date_users",                         precision: 6
    t.date      "login_date"
    t.integer   "write_uid_users"
    t.timestamp "write_date_users",                          precision: 6
    t.text      "signature"
    t.integer   "action_id"
    t.string    "password_crypt",                limit: nil
    t.integer   "alias_id"
    t.boolean   "display_groups_suggestions"
    t.integer   "default_section_id"
    t.boolean   "share"
    t.boolean   "display_employees_suggestions"
    t.string    "ean13_users",                   limit: 13
    t.integer   "pos_config"
  end

  create_table "tablon_mes_anterior", id: false, force: true do |t|
    t.integer   "id_centro",                     limit: 8,                                null: false
    t.integer   "id_propietario",                limit: 8,                                null: false
    t.text      "nombre_centro",                                                          null: false
    t.string    "dir_centro",                    limit: 120
    t.string    "sector_centro",                 limit: 120
    t.string    "comuna_centro",                 limit: 50
    t.string    "rut_centro",                    limit: 25
    t.string    "web",                           limit: 80
    t.string    "email",                         limit: 50
    t.string    "telefonos",                     limit: 120
    t.string    "anexo",                         limit: 20
    t.string    "plan",                          limit: 80
    t.integer   "id_order"
    t.timestamp "create_date_order",                         precision: 6
    t.integer   "sale_journal"
    t.string    "pos_reference",                 limit: nil
    t.integer   "write_uid_order"
    t.integer   "account_move"
    t.timestamp "date_order",                                precision: 6
    t.integer   "location_id"
    t.integer   "nb_print"
    t.integer   "create_uid_order"
    t.integer   "user_id_order"
    t.integer   "partner_id_order"
    t.integer   "company_id_order"
    t.text      "note"
    t.string    "state",                         limit: nil
    t.integer   "pricelist_id"
    t.timestamp "write_date_order",                          precision: 6
    t.string    "name_order",                    limit: nil
    t.integer   "invoice_id"
    t.integer   "session_id"
    t.integer   "picking_id"
    t.integer   "sequence_number"
    t.string    "customer_email",                limit: nil
    t.integer   "id_centro_order_line"
    t.integer   "id_order_line"
    t.integer   "create_uid_order_line"
    t.string    "notice",                        limit: nil
    t.timestamp "create_date_order_line",                    precision: 6
    t.string    "name_order_line",               limit: nil
    t.integer   "order_id"
    t.decimal   "price_unit"
    t.decimal   "price_subtotal"
    t.integer   "company_id"
    t.decimal   "price_subtotal_incl"
    t.decimal   "qty"
    t.decimal   "discount"
    t.timestamp "write_date_order_line",                     precision: 6
    t.integer   "write_uid_order_line"
    t.integer   "product_id"
    t.text      "comments"
    t.text      "order_line_note"
    t.integer   "id_product"
    t.string    "ean13_product",                 limit: 13
    t.timestamp "create_date_product",                       precision: 6
    t.string    "default_code",                  limit: nil
    t.string    "name_template",                 limit: nil
    t.integer   "create_uid_product"
    t.timestamp "message_last_post_product",                 precision: 6
    t.integer   "product_tmpl_id"
    t.binary    "image_variant"
    t.integer   "write_uid_product"
    t.timestamp "write_date_product",                        precision: 6
    t.boolean   "active_product"
    t.integer   "id_prop",                       limit: 8
    t.string    "nombre_propietario",            limit: 120
    t.string    "rut_propietario",               limit: 15
    t.string    "dir_propietario",               limit: 120
    t.integer   "id_partner"
    t.string    "name_partner",                  limit: nil
    t.integer   "company_id_partner"
    t.text      "comment"
    t.string    "ean13_partner",                 limit: 13
    t.timestamp "create_date_partner",                       precision: 6
    t.integer   "color"
    t.binary    "image_small"
    t.binary    "image"
    t.date      "date_partner"
    t.string    "street",                        limit: nil
    t.string    "city",                          limit: nil
    t.string    "display_name",                  limit: nil
    t.string    "zip",                           limit: 24
    t.integer   "title"
    t.string    "function",                      limit: nil
    t.integer   "country_id"
    t.integer   "parent_id"
    t.boolean   "supplier"
    t.string    "ref",                           limit: nil
    t.string    "email_partner",                 limit: nil
    t.boolean   "is_company"
    t.string    "website",                       limit: nil
    t.boolean   "customer"
    t.string    "fax",                           limit: nil
    t.string    "street2",                       limit: nil
    t.boolean   "employee"
    t.float     "credit_limit"
    t.timestamp "write_date",                                precision: 6
    t.boolean   "active_partner"
    t.string    "tz",                            limit: 64
    t.integer   "write_uid"
    t.string    "lang",                          limit: nil
    t.integer   "create_uid"
    t.binary    "image_medium"
    t.string    "phone",                         limit: nil
    t.string    "mobile",                        limit: nil
    t.string    "type",                          limit: nil
    t.boolean   "use_parent_address"
    t.integer   "user_id"
    t.string    "birthdate",                     limit: nil
    t.string    "vat",                           limit: nil
    t.integer   "state_id"
    t.integer   "commercial_partner_id"
    t.string    "notify_email",                  limit: nil
    t.timestamp "message_last_post",                         precision: 6
    t.boolean   "opt_out"
    t.integer   "section_id"
    t.string    "signup_type",                   limit: nil
    t.timestamp "signup_expiration",                         precision: 6
    t.string    "signup_token",                  limit: nil
    t.timestamp "calendar_last_notif_ack",                   precision: 6
    t.timestamp "last_reconciliation_date",                  precision: 6
    t.float     "debit_limit"
    t.boolean   "vat_subjected"
    t.boolean   "prefer_ereceipt"
    t.integer   "id_centro_users"
    t.integer   "id_users"
    t.boolean   "active",                                                  default: true
    t.string    "login",                         limit: 64
    t.string    "password",                      limit: nil
    t.integer   "company_id_users"
    t.integer   "partner_id"
    t.integer   "create_uid_users"
    t.timestamp "create_date_users",                         precision: 6
    t.date      "login_date"
    t.integer   "write_uid_users"
    t.timestamp "write_date_users",                          precision: 6
    t.text      "signature"
    t.integer   "action_id"
    t.string    "password_crypt",                limit: nil
    t.integer   "alias_id"
    t.boolean   "display_groups_suggestions"
    t.integer   "default_section_id"
    t.boolean   "share"
    t.boolean   "display_employees_suggestions"
    t.string    "ean13_users",                   limit: 13
    t.integer   "pos_config"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
