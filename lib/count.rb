module Count
  def self.count_stuff(command)
    match = command.match(/^cuantas\s+(palabras?|lineas?|caracteres?)\s+hay?\s+en\s+(.+)$/i) ||
	    command.match(/^cuantas\s+(palabras?|líneas?|caracteres?)\s+hay?\s+en\s+(.+)$/i) ||
	    command.match(/^cuantos\s+(palabras?|lineas?|caracteres?)\s+hay?\s+en\s+(.+)$/i) ||
	    command.match(/^cuenta\s+el\s+numero\s+total\s+de\s+(palabras?|lineas?|caracteres?)\s+en\s+(.+)$/i)
    
    
    if match
      what = match[1].strip.downcase
      where = match[2].strip
      is_this_directory = where == '.' || where.downcase.match(/^(este\s+)?(?:directorio|carpeta|ruta)?$/) || where.downcase.match(/^(esta\s+)?(?:directorio|carpeta|ruta)?$/)
      
      flag = nil
      if what == "palabras" || what == "words"
        what = "words"
        flag = "w"
      elsif what == "lineas" || what == "línea"
        what = "líneas"
        flag = "l"
      elsif ["char", "chars", "caracteres", "characters"].include?(what)
        what = "characters"
        flag = "c"
      end
      
      {
        :command => "find #{ is_this_directory ? '.' : where } -type f -exec wc -#{ flag } \{\} \\; | awk '{total += $1} END {print total}'",
        :explanation => "Counts the total number of #{ what } in #{ is_this_directory ? 'all the files in the current directory, including subdirectories' : where }."
      }
    end
  end
  
  def self.interpret(command)
    responses = []
    
    count_stuff_command = self.count_stuff(command)
    responses << count_stuff_command if count_stuff_command
    
    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Contar",
      :description => '\033[34mCount\033[0m',
      :usage => ["- betty cuantas palabras hay en este directorio",
      "- betty lineas hay en este directorio",
      "- betty cuantos caracteres hay en mi_archivo.py",
      "- betty cuenta las líneas en esta carpeta",
      "- betty cuenta las líneas en este directorio",
      "(Note that there're many ways to say more or less the same thing.)"]
    }
    commands
  end
end

$executors << Count
