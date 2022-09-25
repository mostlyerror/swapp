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

ActiveRecord::Schema.define(version: 2022_09_24_214711) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "fuzzystrmatch"
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "availabilities", force: :cascade do |t|
    t.bigint "hotel_id", null: false
    t.bigint "swap_id", null: false
    t.date "date", null: false
    t.integer "vacant"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "log_data"
    t.index ["hotel_id", "swap_id", "date"], name: "index_availabilities_on_hotel_id_and_swap_id_and_date", unique: true
    t.index ["hotel_id"], name: "index_availabilities_on_hotel_id"
    t.index ["swap_id"], name: "index_availabilities_on_swap_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.date "date_of_birth"
    t.string "gender"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "ethnicity"
    t.string "email"
    t.string "phone_number"
    t.jsonb "race", default: []
    t.boolean "veteran"
    t.string "veteran_military_branch"
    t.string "veteran_separation_year"
    t.string "veteran_discharge_status"
    t.jsonb "family_members", default: {}
    t.boolean "banned", default: false
    t.boolean "force_intake", default: false
    t.jsonb "log_data"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name"
    t.string "phone"
    t.string "email"
    t.string "title"
    t.string "preferred_contact_method"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "log_data"
  end

  create_table "data_migrations", primary_key: "version", id: :string, force: :cascade do |t|
  end

  create_table "hotels", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "pet_friendly", default: false
    t.boolean "active", default: true
    t.jsonb "address", default: "{}"
    t.jsonb "log_data"
    t.datetime "deleted_at"
  end

  create_table "hotels_contacts", force: :cascade do |t|
    t.bigint "hotel_id"
    t.bigint "contact_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "log_data"
    t.index ["contact_id"], name: "index_hotels_contacts_on_contact_id"
    t.index ["hotel_id", "contact_id"], name: "index_hotels_contacts_on_hotel_id_and_contact_id", unique: true
    t.index ["hotel_id"], name: "index_hotels_contacts_on_hotel_id"
  end

  create_table "hotels_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "hotel_id", null: false
    t.jsonb "log_data"
    t.index ["hotel_id"], name: "index_hotels_users_on_hotel_id"
    t.index ["user_id"], name: "index_hotels_users_on_user_id"
  end

  create_table "incident_reports", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.text "description"
    t.datetime "occurred_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "reporter_id"
    t.integer "hotel_id"
    t.boolean "red_flag", default: false
    t.jsonb "log_data"
    t.index ["client_id"], name: "index_incident_reports_on_client_id"
    t.index ["reporter_id"], name: "index_incident_reports_on_reporter_id"
  end

  create_table "intakes", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "homelessness_first_time"
    t.string "homelessness_how_long_this_time"
    t.boolean "episodes_last_three_years_fewer_than_four_times"
    t.string "total_how_long_shelters_or_streets"
    t.string "are_you_working"
    t.boolean "armed_forces"
    t.boolean "active_duty"
    t.boolean "substance_abuse"
    t.boolean "chronic_health_condition"
    t.boolean "mental_health_condition"
    t.boolean "mental_health_disability"
    t.boolean "physical_disability"
    t.boolean "developmental_disability"
    t.boolean "fleeing_domestic_violence"
    t.string "last_permanent_residence_county"
    t.string "substance_misuse"
    t.string "homelessness_total_last_three_years"
    t.boolean "have_you_ever_experienced_homelessness_before"
    t.string "health_insurance"
    t.jsonb "non_cash_benefits", default: []
    t.string "homelessness_episodes_last_three_years"
    t.boolean "income_source_any"
    t.integer "income_source_earned_income"
    t.integer "income_source_ssdi"
    t.integer "income_source_ssi"
    t.integer "income_source_unemployment_insurance"
    t.integer "income_source_tanf"
    t.integer "income_source_child_support"
    t.integer "income_source_retirement"
    t.integer "income_source_alimony"
    t.integer "income_source_veteran_service_compensation"
    t.integer "income_source_general_assistance"
    t.date "homelessness_date_began"
    t.boolean "household_tanf"
    t.jsonb "log_data"
    t.bigint "swap_id"
    t.index ["client_id"], name: "index_intakes_on_client_id"
    t.index ["swap_id"], name: "index_intakes_on_swap_id"
    t.index ["user_id"], name: "index_intakes_on_user_id"
  end

  create_table "red_flags", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "hotel_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "log_data"
    t.index ["client_id"], name: "index_red_flags_on_client_id"
    t.index ["hotel_id"], name: "index_red_flags_on_hotel_id"
  end

  create_table "short_intakes", force: :cascade do |t|
    t.string "where_did_you_sleep_last_night"
    t.string "what_city_did_you_sleep_in_last_night"
    t.string "why_not_shelter", default: [], array: true
    t.boolean "bus_pass"
    t.boolean "king_soopers_card"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "client_id", null: false
    t.bigint "user_id", null: false
    t.boolean "household_composition_changed"
    t.jsonb "log_data"
    t.bigint "swap_id"
    t.string "pets"
    t.boolean "vehicle"
    t.string "identification"
    t.index ["client_id"], name: "index_short_intakes_on_client_id"
    t.index ["swap_id"], name: "index_short_intakes_on_swap_id"
    t.index ["user_id"], name: "index_short_intakes_on_user_id"
  end

  create_table "swaps", force: :cascade do |t|
    t.date "start_date", null: false
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "intake_dates", default: [], array: true
    t.jsonb "log_data"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin_user", default: false, null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.boolean "hotel_user", default: false, null: false
    t.boolean "intake_user", default: false, null: false
    t.boolean "show_swap_panel", default: true
    t.boolean "active", default: true
    t.jsonb "log_data"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vouchers", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "user_id", null: false
    t.bigint "hotel_id", null: false
    t.date "check_in", null: false
    t.date "check_out", null: false
    t.string "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "swap_id"
    t.integer "num_adults_in_household"
    t.integer "num_children_in_household"
    t.integer "guest_ids", default: [], array: true
    t.text "notes"
    t.jsonb "log_data"
    t.datetime "voided_at"
    t.bigint "voided_by_id"
    t.index ["client_id", "swap_id"], name: "index_vouchers_on_client_id_and_swap_id"
    t.index ["client_id"], name: "index_vouchers_on_client_id"
    t.index ["hotel_id"], name: "index_vouchers_on_hotel_id"
    t.index ["swap_id"], name: "index_vouchers_on_swap_id"
    t.index ["user_id"], name: "index_vouchers_on_user_id"
    t.index ["voided_by_id"], name: "index_vouchers_on_voided_by_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "availabilities", "hotels"
  add_foreign_key "availabilities", "swaps"
  add_foreign_key "incident_reports", "clients"
  add_foreign_key "incident_reports", "users", column: "reporter_id"
  add_foreign_key "intakes", "clients"
  add_foreign_key "intakes", "swaps"
  add_foreign_key "intakes", "users"
  add_foreign_key "red_flags", "clients"
  add_foreign_key "red_flags", "hotels"
  add_foreign_key "short_intakes", "clients"
  add_foreign_key "short_intakes", "swaps"
  add_foreign_key "short_intakes", "users"
  add_foreign_key "vouchers", "clients"
  add_foreign_key "vouchers", "hotels"
  add_foreign_key "vouchers", "swaps"
  add_foreign_key "vouchers", "users"
  add_foreign_key "vouchers", "users", column: "voided_by_id"
  create_function :pg_search_dmetaphone, sql_definition: <<-SQL
      CREATE OR REPLACE FUNCTION public.pg_search_dmetaphone(text)
       RETURNS text
       LANGUAGE sql
       IMMUTABLE STRICT
      AS $function$ SELECT array_to_string(ARRAY(SELECT dmetaphone(unnest(regexp_split_to_array($1, E'\s+')))), ' ') $function$
  SQL
  create_function :logidze_logger, sql_definition: <<-SQL
      CREATE OR REPLACE FUNCTION public.logidze_logger()
       RETURNS trigger
       LANGUAGE plpgsql
      AS $function$
        -- version: 2
        DECLARE
          changes jsonb;
          version jsonb;
          snapshot jsonb;
          new_v integer;
          size integer;
          history_limit integer;
          debounce_time integer;
          current_version integer;
          k text;
          iterator integer;
          item record;
          columns text[];
          include_columns boolean;
          ts timestamp with time zone;
          ts_column text;
          err_sqlstate text;
          err_message text;
          err_detail text;
          err_hint text;
          err_context text;
          err_table_name text;
          err_schema_name text;
          err_jsonb jsonb;
          err_captured boolean;
        BEGIN
          ts_column := NULLIF(TG_ARGV[1], 'null');
          columns := NULLIF(TG_ARGV[2], 'null');
          include_columns := NULLIF(TG_ARGV[3], 'null');

          IF TG_OP = 'INSERT' THEN
            IF columns IS NOT NULL THEN
              snapshot = logidze_snapshot(to_jsonb(NEW.*), ts_column, columns, include_columns);
            ELSE
              snapshot = logidze_snapshot(to_jsonb(NEW.*), ts_column);
            END IF;

            IF snapshot#>>'{h, -1, c}' != '{}' THEN
              NEW.log_data := snapshot;
            END IF;

          ELSIF TG_OP = 'UPDATE' THEN

            IF OLD.log_data is NULL OR OLD.log_data = '{}'::jsonb THEN
              IF columns IS NOT NULL THEN
                snapshot = logidze_snapshot(to_jsonb(NEW.*), ts_column, columns, include_columns);
              ELSE
                snapshot = logidze_snapshot(to_jsonb(NEW.*), ts_column);
              END IF;

              IF snapshot#>>'{h, -1, c}' != '{}' THEN
                NEW.log_data := snapshot;
              END IF;
              RETURN NEW;
            END IF;

            history_limit := NULLIF(TG_ARGV[0], 'null');
            debounce_time := NULLIF(TG_ARGV[4], 'null');

            current_version := (NEW.log_data->>'v')::int;

            IF ts_column IS NULL THEN
              ts := statement_timestamp();
            ELSE
              ts := (to_jsonb(NEW.*)->>ts_column)::timestamp with time zone;
              IF ts IS NULL OR ts = (to_jsonb(OLD.*)->>ts_column)::timestamp with time zone THEN
                ts := statement_timestamp();
              END IF;
            END IF;

            IF NEW = OLD THEN
              RETURN NEW;
            END IF;

            IF current_version < (NEW.log_data#>>'{h,-1,v}')::int THEN
              iterator := 0;
              FOR item in SELECT * FROM jsonb_array_elements(NEW.log_data->'h')
              LOOP
                IF (item.value->>'v')::int > current_version THEN
                  NEW.log_data := jsonb_set(
                    NEW.log_data,
                    '{h}',
                    (NEW.log_data->'h') - iterator
                  );
                END IF;
                iterator := iterator + 1;
              END LOOP;
            END IF;

            changes := '{}';

            IF (coalesce(current_setting('logidze.full_snapshot', true), '') = 'on') THEN
              BEGIN
                changes = hstore_to_jsonb_loose(hstore(NEW.*));
              EXCEPTION
                WHEN NUMERIC_VALUE_OUT_OF_RANGE THEN
                  changes = row_to_json(NEW.*)::jsonb;
                  FOR k IN (SELECT key FROM jsonb_each(changes))
                  LOOP
                    IF jsonb_typeof(changes->k) = 'object' THEN
                      changes = jsonb_set(changes, ARRAY[k], to_jsonb(changes->>k));
                    END IF;
                  END LOOP;
              END;
            ELSE
              BEGIN
                changes = hstore_to_jsonb_loose(
                      hstore(NEW.*) - hstore(OLD.*)
                  );
              EXCEPTION
                WHEN NUMERIC_VALUE_OUT_OF_RANGE THEN
                  changes = (SELECT
                    COALESCE(json_object_agg(key, value), '{}')::jsonb
                    FROM
                    jsonb_each(row_to_json(NEW.*)::jsonb)
                    WHERE NOT jsonb_build_object(key, value) <@ row_to_json(OLD.*)::jsonb);
                  FOR k IN (SELECT key FROM jsonb_each(changes))
                  LOOP
                    IF jsonb_typeof(changes->k) = 'object' THEN
                      changes = jsonb_set(changes, ARRAY[k], to_jsonb(changes->>k));
                    END IF;
                  END LOOP;
              END;
            END IF;

            changes = changes - 'log_data';

            IF columns IS NOT NULL THEN
              changes = logidze_filter_keys(changes, columns, include_columns);
            END IF;

            IF changes = '{}' THEN
              RETURN NEW;
            END IF;

            new_v := (NEW.log_data#>>'{h,-1,v}')::int + 1;

            size := jsonb_array_length(NEW.log_data->'h');
            version := logidze_version(new_v, changes, ts);

            IF (
              debounce_time IS NOT NULL AND
              (version->>'ts')::bigint - (NEW.log_data#>'{h,-1,ts}')::text::bigint <= debounce_time
            ) THEN
              -- merge new version with the previous one
              new_v := (NEW.log_data#>>'{h,-1,v}')::int;
              version := logidze_version(new_v, (NEW.log_data#>'{h,-1,c}')::jsonb || changes, ts);
              -- remove the previous version from log
              NEW.log_data := jsonb_set(
                NEW.log_data,
                '{h}',
                (NEW.log_data->'h') - (size - 1)
              );
            END IF;

            NEW.log_data := jsonb_set(
              NEW.log_data,
              ARRAY['h', size::text],
              version,
              true
            );

            NEW.log_data := jsonb_set(
              NEW.log_data,
              '{v}',
              to_jsonb(new_v)
            );

            IF history_limit IS NOT NULL AND history_limit <= size THEN
              NEW.log_data := logidze_compact_history(NEW.log_data, size - history_limit + 1);
            END IF;
          END IF;

          return NEW;
        EXCEPTION
          WHEN OTHERS THEN
            GET STACKED DIAGNOSTICS err_sqlstate = RETURNED_SQLSTATE,
                                    err_message = MESSAGE_TEXT,
                                    err_detail = PG_EXCEPTION_DETAIL,
                                    err_hint = PG_EXCEPTION_HINT,
                                    err_context = PG_EXCEPTION_CONTEXT,
                                    err_schema_name = SCHEMA_NAME,
                                    err_table_name = TABLE_NAME;
            err_jsonb := jsonb_build_object(
              'returned_sqlstate', err_sqlstate,
              'message_text', err_message,
              'pg_exception_detail', err_detail,
              'pg_exception_hint', err_hint,
              'pg_exception_context', err_context,
              'schema_name', err_schema_name,
              'table_name', err_table_name
            );
            err_captured = logidze_capture_exception(err_jsonb);
            IF err_captured THEN
              return NEW;
            ELSE
              RAISE;
            END IF;
        END;
      $function$
  SQL
  create_function :logidze_capture_exception, sql_definition: <<-SQL
      CREATE OR REPLACE FUNCTION public.logidze_capture_exception(error_data jsonb)
       RETURNS boolean
       LANGUAGE plpgsql
      AS $function$
        -- version: 1
      BEGIN
        -- Feel free to change this function to change Logidze behavior on exception.
        --
        -- Return `false` to raise exception or `true` to commit record changes.
        --
        -- `error_data` contains:
        --   - returned_sqlstate
        --   - message_text
        --   - pg_exception_detail
        --   - pg_exception_hint
        --   - pg_exception_context
        --   - schema_name
        --   - table_name
        -- Learn more about available keys:
        -- https://www.postgresql.org/docs/9.6/plpgsql-control-structures.html#PLPGSQL-EXCEPTION-DIAGNOSTICS-VALUES
        --

        return false;
      END;
      $function$
  SQL
  create_function :logidze_version, sql_definition: <<-SQL
      CREATE OR REPLACE FUNCTION public.logidze_version(v bigint, data jsonb, ts timestamp with time zone)
       RETURNS jsonb
       LANGUAGE plpgsql
      AS $function$
        -- version: 2
        DECLARE
          buf jsonb;
        BEGIN
          data = data - 'log_data';
          buf := jsonb_build_object(
                    'ts',
                    (extract(epoch from ts) * 1000)::bigint,
                    'v',
                    v,
                    'c',
                    data
                    );
          IF coalesce(current_setting('logidze.meta', true), '') <> '' THEN
            buf := jsonb_insert(buf, '{m}', current_setting('logidze.meta')::jsonb);
          END IF;
          RETURN buf;
        END;
      $function$
  SQL
  create_function :logidze_snapshot, sql_definition: <<-SQL
      CREATE OR REPLACE FUNCTION public.logidze_snapshot(item jsonb, ts_column text DEFAULT NULL::text, columns text[] DEFAULT NULL::text[], include_columns boolean DEFAULT false)
       RETURNS jsonb
       LANGUAGE plpgsql
      AS $function$
        -- version: 3
        DECLARE
          ts timestamp with time zone;
          k text;
        BEGIN
          item = item - 'log_data';
          IF ts_column IS NULL THEN
            ts := statement_timestamp();
          ELSE
            ts := coalesce((item->>ts_column)::timestamp with time zone, statement_timestamp());
          END IF;

          IF columns IS NOT NULL THEN
            item := logidze_filter_keys(item, columns, include_columns);
          END IF;

          FOR k IN (SELECT key FROM jsonb_each(item))
          LOOP
            IF jsonb_typeof(item->k) = 'object' THEN
               item := jsonb_set(item, ARRAY[k], to_jsonb(item->>k));
            END IF;
          END LOOP;

          return json_build_object(
            'v', 1,
            'h', jsonb_build_array(
                    logidze_version(1, item, ts)
                  )
            );
        END;
      $function$
  SQL
  create_function :logidze_filter_keys, sql_definition: <<-SQL
      CREATE OR REPLACE FUNCTION public.logidze_filter_keys(obj jsonb, keys text[], include_columns boolean DEFAULT false)
       RETURNS jsonb
       LANGUAGE plpgsql
      AS $function$
        -- version: 1
        DECLARE
          res jsonb;
          key text;
        BEGIN
          res := '{}';

          IF include_columns THEN
            FOREACH key IN ARRAY keys
            LOOP
              IF obj ? key THEN
                res = jsonb_insert(res, ARRAY[key], obj->key);
              END IF;
            END LOOP;
          ELSE
            res = obj;
            FOREACH key IN ARRAY keys
            LOOP
              res = res - key;
            END LOOP;
          END IF;

          RETURN res;
        END;
      $function$
  SQL
  create_function :logidze_compact_history, sql_definition: <<-SQL
      CREATE OR REPLACE FUNCTION public.logidze_compact_history(log_data jsonb, cutoff integer DEFAULT 1)
       RETURNS jsonb
       LANGUAGE plpgsql
      AS $function$
        -- version: 1
        DECLARE
          merged jsonb;
        BEGIN
          LOOP
            merged := jsonb_build_object(
              'ts',
              log_data#>'{h,1,ts}',
              'v',
              log_data#>'{h,1,v}',
              'c',
              (log_data#>'{h,0,c}') || (log_data#>'{h,1,c}')
            );

            IF (log_data#>'{h,1}' ? 'm') THEN
              merged := jsonb_set(merged, ARRAY['m'], log_data#>'{h,1,m}');
            END IF;

            log_data := jsonb_set(
              log_data,
              '{h}',
              jsonb_set(
                log_data->'h',
                '{1}',
                merged
              ) - 0
            );

            cutoff := cutoff - 1;

            EXIT WHEN cutoff <= 0;
          END LOOP;

          return log_data;
        END;
      $function$
  SQL


  create_trigger :logidze_on_availabilities, sql_definition: <<-SQL
      CREATE TRIGGER logidze_on_availabilities BEFORE INSERT OR UPDATE ON public.availabilities FOR EACH ROW WHEN ((COALESCE(current_setting('logidze.disabled'::text, true), ''::text) <> 'on'::text)) EXECUTE FUNCTION logidze_logger('null', 'updated_at')
  SQL
  create_trigger :logidze_on_clients, sql_definition: <<-SQL
      CREATE TRIGGER logidze_on_clients BEFORE INSERT OR UPDATE ON public.clients FOR EACH ROW WHEN ((COALESCE(current_setting('logidze.disabled'::text, true), ''::text) <> 'on'::text)) EXECUTE FUNCTION logidze_logger('null', 'updated_at')
  SQL
  create_trigger :logidze_on_contacts, sql_definition: <<-SQL
      CREATE TRIGGER logidze_on_contacts BEFORE INSERT OR UPDATE ON public.contacts FOR EACH ROW WHEN ((COALESCE(current_setting('logidze.disabled'::text, true), ''::text) <> 'on'::text)) EXECUTE FUNCTION logidze_logger('null', 'updated_at')
  SQL
  create_trigger :logidze_on_hotels, sql_definition: <<-SQL
      CREATE TRIGGER logidze_on_hotels BEFORE INSERT OR UPDATE ON public.hotels FOR EACH ROW WHEN ((COALESCE(current_setting('logidze.disabled'::text, true), ''::text) <> 'on'::text)) EXECUTE FUNCTION logidze_logger('null', 'updated_at')
  SQL
  create_trigger :logidze_on_hotels_contacts, sql_definition: <<-SQL
      CREATE TRIGGER logidze_on_hotels_contacts BEFORE INSERT OR UPDATE ON public.hotels_contacts FOR EACH ROW WHEN ((COALESCE(current_setting('logidze.disabled'::text, true), ''::text) <> 'on'::text)) EXECUTE FUNCTION logidze_logger('null', 'updated_at')
  SQL
  create_trigger :logidze_on_hotels_users, sql_definition: <<-SQL
      CREATE TRIGGER logidze_on_hotels_users BEFORE INSERT OR UPDATE ON public.hotels_users FOR EACH ROW WHEN ((COALESCE(current_setting('logidze.disabled'::text, true), ''::text) <> 'on'::text)) EXECUTE FUNCTION logidze_logger('null', 'updated_at')
  SQL
  create_trigger :logidze_on_incident_reports, sql_definition: <<-SQL
      CREATE TRIGGER logidze_on_incident_reports BEFORE INSERT OR UPDATE ON public.incident_reports FOR EACH ROW WHEN ((COALESCE(current_setting('logidze.disabled'::text, true), ''::text) <> 'on'::text)) EXECUTE FUNCTION logidze_logger('null', 'updated_at')
  SQL
  create_trigger :logidze_on_intakes, sql_definition: <<-SQL
      CREATE TRIGGER logidze_on_intakes BEFORE INSERT OR UPDATE ON public.intakes FOR EACH ROW WHEN ((COALESCE(current_setting('logidze.disabled'::text, true), ''::text) <> 'on'::text)) EXECUTE FUNCTION logidze_logger('null', 'updated_at')
  SQL
  create_trigger :logidze_on_red_flags, sql_definition: <<-SQL
      CREATE TRIGGER logidze_on_red_flags BEFORE INSERT OR UPDATE ON public.red_flags FOR EACH ROW WHEN ((COALESCE(current_setting('logidze.disabled'::text, true), ''::text) <> 'on'::text)) EXECUTE FUNCTION logidze_logger('null', 'updated_at')
  SQL
  create_trigger :logidze_on_short_intakes, sql_definition: <<-SQL
      CREATE TRIGGER logidze_on_short_intakes BEFORE INSERT OR UPDATE ON public.short_intakes FOR EACH ROW WHEN ((COALESCE(current_setting('logidze.disabled'::text, true), ''::text) <> 'on'::text)) EXECUTE FUNCTION logidze_logger('null', 'updated_at')
  SQL
  create_trigger :logidze_on_swaps, sql_definition: <<-SQL
      CREATE TRIGGER logidze_on_swaps BEFORE INSERT OR UPDATE ON public.swaps FOR EACH ROW WHEN ((COALESCE(current_setting('logidze.disabled'::text, true), ''::text) <> 'on'::text)) EXECUTE FUNCTION logidze_logger('null', 'updated_at')
  SQL
  create_trigger :logidze_on_users, sql_definition: <<-SQL
      CREATE TRIGGER logidze_on_users BEFORE INSERT OR UPDATE ON public.users FOR EACH ROW WHEN ((COALESCE(current_setting('logidze.disabled'::text, true), ''::text) <> 'on'::text)) EXECUTE FUNCTION logidze_logger('null', 'updated_at')
  SQL
  create_trigger :logidze_on_vouchers, sql_definition: <<-SQL
      CREATE TRIGGER logidze_on_vouchers BEFORE INSERT OR UPDATE ON public.vouchers FOR EACH ROW WHEN ((COALESCE(current_setting('logidze.disabled'::text, true), ''::text) <> 'on'::text)) EXECUTE FUNCTION logidze_logger('null', 'updated_at')
  SQL
end
