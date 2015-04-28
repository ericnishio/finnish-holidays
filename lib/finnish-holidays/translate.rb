module FinnishHolidays
  module Translate
    def self.into(language, original)
      translations = {
        "New Year's Day" => {
          'fi' => 'Uudenvuodenpäivä',
          'sv' => 'Nyårsdagen'
        },
        'Epiphany' => {
          'fi' => 'Loppiainen',
          'sv' => 'Trettondedagen'
        },
        'Good Friday' => {
          'fi' => 'Pitkäperjantai',
          'sv' => 'Långfredagen'
        },
        'Easter Sunday' => {
          'fi' => 'Pääsiäispäivä',
          'sv' => 'Påskdagen'
        },
        'Easter Monday' => {
          'fi' => 'Toinen pääsiäispäivä',
          'sv' => 'Andra påskdagen'
        },
        'May Day' => {
          'fi' => 'Vappu',
          'sv' => 'Valborgsmässoafton'
        },
        'Ascension Day' => {
          'fi' => 'Helatorstai',
          'sv' => 'Kristi himmelfärds dag'
        },
        'Pentecost' => {
          'fi' => 'Helluntaipäivä',
          'sv' => 'Pingst'
        },
        'Midsummer Eve (unofficial)' => {
          'fi' => 'Juhannusaatto (unofficial)',
          'sv' => 'Midsommarafton (unofficial)'
        },
        'Midsummer Day' => {
          'fi' => 'Juhannuspäivä',
          'sv' => 'Midsommardagen'
        },
        "All Saints' Day" => {
          'fi' => 'Pyhäinpäivä',
          'sv' => 'Alla helgons dag'
        },
        'Independence Day' => {
          'fi' => 'Itsenäisyyspäivä',
          'sv' => 'Självständighetsdagen'
        },
        'Christmas Eve (unofficial)' => {
          'fi' => 'Jouluaatto (unofficial)',
          'sv' => 'Julafton (unofficial)'
        },
        'Christmas Day' => {
          'fi' => 'Joulupäivä',
          'sv' => 'Juldagen'
        },
        "St. Stephen's Day" => {
          'fi' => 'Tapaninpäivä',
          'sv' => 'Andra juldagen'
        }
      }

      if translations[original] && (translations[original][language].is_a? String)
        return translations[original][language]
      else
        return original
      end
    end
  end
end
