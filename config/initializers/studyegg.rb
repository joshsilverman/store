studyegg_config_file = File.join(Rails.root,'config','studyegg.yml')
raise "#{studyegg_config_file} is missing!" unless File.exists? studyegg_config_file
studyegg_config = YAML.load_file(studyegg_config_file)[Rails.env].symbolize_keys

STUDYEGG_PATH = studyegg_config[:studyegg]
STUDYEGG_STORE_PATH = studyegg_config[:store]
STUDYEGG_QUESTIONS_PATH = studyegg_config[:qb]
STUDYEGG_USER_MANAGER_PATH = studyegg_config[:auth]