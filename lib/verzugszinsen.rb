require 'yaml'

class Verzugszinsen

  PRECISION  = 4
  ZINSSAETZE = File.dirname(__FILE__)+"/basiszinssatz.yml"

  Zeitraum = Struct.new(:begin, :end, :tage, :zinssatz, :zinsertrag)

  def self.basiszinssatz
    @basiszinssatz ||= YAML.load_file ZINSSAETZE
  end

  attr_reader :ausgangsforderung, :entries, :prozent

  def initialize(ausgangsforderung, daterange, prozent)
    @ausgangsforderung = ausgangsforderung
    @prozent           = prozent
    @days              = daterange.to_a
    @entries           = []

    self.class.basiszinssatz.each do |start, basiszins|
      # Zu berücksichtigende Tage
      range = (start..((start >> 6) - 1)).to_a & @days

      # Anzahl der Tage im Zinszeitraum
      count = range.count
      if count > 0
        proz  = (basiszins + @prozent).round(2)
        zins  = ausgangsforderung * proz / 100 * count / (Date.new(start.year+1) - Date.new(start.year)).to_i
        zins  = zins.round(PRECISION)

        @entries << Zeitraum.new(range.first, range.last, count, proz, zins)
      end
    end

    if @entries.inject(0){|sum,e| sum + e.tage} != @days.count
      raise "Basiszinssatz-Tabelle ist unvollständig (#{ZINSSAETZE})"
    end
  end

  def begin
    @days.first
  end

  def zinsen
    @zinsen ||= @entries.inject(0){|sum,e| sum + e.zinsertrag }.round(2)
  end

  def gesamtforderung
    ausgangsforderung + zinsen
  end

  def inspect
    out = []
    out << "Zeitraum                  | Tage | Zinssatz | Zinsertrag"
    out << "--------------------------------------------------------"
    
    @entries.each do |entry|
      out << sprintf("%s bis %s | %04s |    %5.2f | %10.#{PRECISION}f", entry.begin, entry.end, entry.tage, entry.zinssatz, entry.zinsertrag)
    end

    out << '--------------------------------------------------------'
    out << sprintf("Ausgangsforderung: %10.2f", ausgangsforderung)
    out << sprintf("Zinsen Gesamt:     %10.2f", zinsen)
    out << sprintf("Gesamtforderung:   %10.2f", gesamtforderung)

    out.join("\n")
  end

end
