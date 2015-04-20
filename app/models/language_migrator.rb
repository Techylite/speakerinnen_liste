class LanguageMigrator

  def self.create_profile_languages(profiles)
    [:en, :de].each do |locale|
      I18n.locale = locale
      Array(profiles).each do |profile|
        I18n.t('iso_639_1').each do |iso_code, language|
          if profile.languages.match(/#{language}|#{iso_code}(\,|\z)|#{custom_matcher(iso_code)}/i)
            ProfileLanguage.create!(profile: profile, iso_639_1: iso_code) unless ProfileLanguage.find_by(profile: profile, iso_639_1: iso_code)
          end
        end
      end
    end

  end

  private

  def self.custom_matcher(iso_code)
    match_hash = Hash.new(/\d{5}/)
    match_hash.merge!({ de: /^D\,/, fr: /^F\,/ })
    match_hash[iso_code]
  end

end
