module Datetime
  def self.interpret(command)
    responses = []
    
    if command.match(/^que\s+hora\ses\s??$/i) || command.match(/^tienes\s+hora\stime$/i) || command.match(/^dime\s+la\s+hora\??$/i)
      responses << {
        :command => "date +\"%T\"",
        :explanation => "Muestra la hora actual."
      }
    end

    if command.match(/^que\s+dia\s+es\s+hoy\s??$/i) || command.match(/^que\s+día\s+es\s+hoy\s??$/i)
      responses << {
        :command => "date +\"%m-%d-%y\"",
        :explanation => "Muestra la fecha actual."
      }
    end

    if command.match(/^que\s+mes\ses??$/i) || command.match(/^en\s+que\s+mes\s+estamos\s?$/i)
      responses << {
        :command => "date +%B",
        :explanation => "Muestra el mes actual"
      }
    end

    if command.match(/^que\s+dia\s+de\s+la\s+semana\s+es\??$/i) ||
       command.match(/^que\s+es\s+hoy$/)
      responses << {
        :command => "date +\"%A\"",
        :explanation => "Muestra el día de la semana actual"
      }
    end

    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Fechahora",
      :description => 'Show information about \033[34mDatetime\033[0m',
      :usage => ["- betty que hora es",
      "- betty que dia es hoy",
      "- betty que mes es",
      "- betty que es hoy",
      "- betty tienes hora"]
    }
    commands
  end
end

$executors << Datetime
