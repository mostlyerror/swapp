CREATE TRIGGER logidze_on_incident_reports
BEFORE UPDATE OR INSERT ON incident_reports FOR EACH ROW
WHEN (coalesce(current_setting('logidze.disabled', true), '') <> 'on')
-- Parameters: history_size_limit (integer), timestamp_column (text), filtered_columns (text[]),
-- include_columns (boolean), debounce_time_ms (integer)
EXECUTE PROCEDURE logidze_logger(null, 'updated_at');
