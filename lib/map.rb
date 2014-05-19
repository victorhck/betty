module Map
  def self.interpret(command)
    responses = []

    if command.match(/^(?:muestrame\s+)?(?:me\s+)?(?:un\s+)?mapa\s+(?:de\s+)?(.+)$/)
      search_term = $1.gsub(' ', '%20')
      command = ""

      case OS.platform_name
        when 'Mac OS'
          command = 'open'
        when 'Linux'
          command = 'xdg-open'
        when 'Windows'
          command = 'start'
      end

      responses << {
        :command => "#{command} https://www.google.com/maps/search/#{ search_term }",
        :explanation => "Abre el navegador con Google Maps buscando '#{ search_term }'."
      }
    end

    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Mapa",
      :description => 'Pull out \033[34mMap\033[0ms from Google',
      :usage => ["- betty muestrame un mapa de España"]
    }
    commands
  end
end

$executors << Map
