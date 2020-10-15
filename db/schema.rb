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

ActiveRecord::Schema.define(version: 2020_10_15_093459) do

  create_table "five_km_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "minute_id"
    t.integer "second_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_five_km_records_on_user_id"
  end

  create_table "follow_relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "follower_id", null: false
    t.bigint "following_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["follower_id", "following_id"], name: "index_follow_relationships_on_follower_id_and_following_id", unique: true
    t.index ["follower_id"], name: "index_follow_relationships_on_follower_id"
    t.index ["following_id"], name: "index_follow_relationships_on_following_id"
  end

  create_table "full_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "hour_id"
    t.integer "minute_id"
    t.integer "second_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_full_records_on_user_id"
  end

  create_table "half_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "hour_id"
    t.integer "minute_id"
    t.integer "second_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_half_records_on_user_id"
  end

  create_table "likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tweet_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tweet_id"], name: "index_likes_on_tweet_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "text"
    t.bigint "user_id", null: false
    t.bigint "tweet_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tweet_id"], name: "index_messages_on_tweet_id"
    t.index ["user_id", "tweet_id", "created_at"], name: "index_messages_on_user_id_and_tweet_id_and_created_at"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "tag_tweets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "tweet_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tag_id"], name: "index_tag_tweets_on_tag_id"
    t.index ["tweet_id", "tag_id"], name: "index_tag_tweets_on_tweet_id_and_tag_id", unique: true
    t.index ["tweet_id"], name: "index_tag_tweets_on_tweet_id"
  end

  create_table "tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ten_km_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "minute_id"
    t.integer "second_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_ten_km_records_on_user_id"
  end

  create_table "tweet_tag_relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "tweet_id"
    t.bigint "tweet_tag_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tweet_id"], name: "index_tweet_tag_relationships_on_tweet_id"
    t.index ["tweet_tag_id"], name: "index_tweet_tag_relationships_on_tweet_tag_id"
  end

  create_table "tweet_tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tweets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content", null: false
    t.string "address", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "place_name", null: false
    t.string "place_image", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "level"
    t.index ["user_id", "created_at"], name: "index_tweets_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_tweets_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "nickname", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.string "introduction"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "five_km_records", "users"
  add_foreign_key "follow_relationships", "users", column: "follower_id"
  add_foreign_key "follow_relationships", "users", column: "following_id"
  add_foreign_key "full_records", "users"
  add_foreign_key "half_records", "users"
  add_foreign_key "likes", "tweets"
  add_foreign_key "likes", "users"
  add_foreign_key "messages", "tweets"
  add_foreign_key "messages", "users"
  add_foreign_key "tag_tweets", "tags"
  add_foreign_key "tag_tweets", "tweets"
  add_foreign_key "ten_km_records", "users"
  add_foreign_key "tweet_tag_relationships", "tweet_tags"
  add_foreign_key "tweet_tag_relationships", "tweets"
  add_foreign_key "tweets", "users"
end
