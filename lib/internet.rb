module Internet
  def self.download(command)
    match = command.match(/^descarga\s+([^\s]{3,})(?:\s+a\s+(.+))?$/i)
    
    if match
      where = match[1].strip
      output = match[2]
      output = output.strip if output
      
      {
        :command => "curl#{ output ? ' -o ' + output : ''} #{ where }".strip,
        :explanation => "Descarga el contenido de una URL a#{ output ? ' to ' + output : '' }."
      }
    end
  end

  def self.uncompress(command)
    match = command.match(/^(?:descomprime|extrae)\s+([^\s]+)(?:\s+(?:a\s+)?(.+))?$/i)
    
    if match
      what_file = match[1].strip
      where = match[2]
      if where.nil?
        where = what_file.split(".").first
      end
      in_same_directory = where == '.' || where.downcase.match(/^((?:this|same)\s+)?(?:dir(?:ectory)|folder|path)?$/)
      
      {
        :command => "#{ in_same_directory ? '' : 'mkdir ' + where + ' && ' } tar -zxvf #{ what_file } #{ in_same_directory ? '' : '-C ' + where }".strip,
        :explanation => "Descomprime el contenido de un archivo #{ what_file }, sacando el contenido en el mismo directorio #{ in_same_directory ? 'this directory' : where }."
      }
    end
  end

  def self.compress(command)
    match = command.match(/^(?:archiva|comprime)\s+([^\s]+)(\s+(?:directorio|carpeta|ruta))?$/i)

    if match
      what_file = match[1].strip

      {
        :command => "cd #{ what_file }; tar -czvf #{ what_file }.tar.gz *",
        :explanation => "Comprime el contenido de #{ what_file } directorio, sacando el resultado en un archivo en el mismo directorio"
      }
    end
  end
  
  def self.interpret(command)
    responses = []
    
    download_command = self.download(command)
    responses << download_command if download_command
    
    uncompress_command = self.uncompress(command)
    responses << uncompress_command if uncompress_command

    compress_command = self.compress(command)
    responses << compress_command if compress_command
    
    responses
  end

  def self.help
    commands = []
    commands << {
      :category => "Internet",
      :description => 'Download files from \033[34mInternet\033[0m, uncompress/compress them',
      :usage => ["- betty descarga http://www.miweb.com/archivo.tar.gz a ~/Ruta/archivo.tar.gz",
      "- betty descomprime archivo.tar.gz",
      "- betty extrae archivo.tar.gz a tu_directorio",
      "(también puedes usar la palabra estrae.)",
      "- betty comprime /ruta/a/directorio"]
    }
    commands
  end
end

$executors << Internet
