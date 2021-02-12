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

ActiveRecord::Schema.define(version: 2021_02_12_003924) do

  create_table "parliamentarians", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.integer "ideCadastro"
    t.string "sgPartido"
    t.integer "upload_file_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["upload_file_id"], name: "index_parliamentarians_on_upload_file_id"
  end

  create_table "parliamentary_expenditures", force: :cascade do |t|
    t.date "datEmissao"
    t.string "txtFornecedor"
    t.float "vlrLiquido"
    t.integer "parliamentarian_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parliamentarian_id"], name: "index_parliamentary_expenditures_on_parliamentarian_id"
  end

  create_table "upload_files", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "parliamentarians", "upload_files"
  add_foreign_key "parliamentary_expenditures", "parliamentarians"
end
