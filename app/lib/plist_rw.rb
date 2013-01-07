module PListRW
  
  # Custom error class used when trying to access a plist file that doesn't exist.
  class NoFileError < StandardError; end

  # Check if a plist file exists in either the main bundle or the documents dir.
  #
  # fileName - The name of the plist file to return, minus the .plist extension
  # directory - A Symbol named either :documentsDir or :mainBundle depending on where you'd like 
  #             to search (defaults: :documentsDir)
  #
  # Returns either True or False
  def self.exist?(fileName, directory = :documentsDir)
    case directory.to_sym
    when :documentsDir
      File.exist?(plistPath(fileName))
    when :mainBundle
      NSBundle.mainBundle.pathForResource(fileName, ofType: "plist")
    else
      raise ArgumentError, "directory must be one of :documentsDir or :mainBundle (was #{directory})"
    end
  end

  # Returns the path to the plist file named fileName as a String
  # 
  # fileName - The name of the plist file to return, minus the .plist extension
  # 
  # Examples
  # 
  #   PListRW.plistPath('awesome')
  #   # => "/Users/Bodacious/Library/Application Support/iPhone Simulator/6.0/Applications/5A54505B-495E-4744-B8F4-DB0727FD161D/Documents/awesome.plist"
  def self.plistPath(fileName)
    File.join(documentsDir, "#{fileName}.plist")
  end

  # Update the plist file with the contents of the object passed
  # 
  # fileName - The name of the plist file to return, minus the .plist extension
  # object - A Hash or Array with the contents of the Plist file
  # 
  # Examples
  #   
  #   @array = [{id: 1, name: "one"}, {id: 2, name: "two"}]
  #   PListRW.updatePlistFileWithObject('awesome', @array)
  #
  #   @hash = {1 => "one", 2 => "two"}
  #   PListRW.updatePlistFileWithObject('awesome', @hash)
  # 
  # Raises NoFileError if the plist file doesn't exist
  def self.updatePlistFileWithObject(fileName, object)
    raise ArgumentError, "Expected object to be an instance of Array or Hash, was #{object.class}" unless object.is_a?(Array) || object.is_a?(Hash)
    raise NoFileError, "Cannot find plist file: #{fileName}.plist in documents directory" unless exist?(fileName)
    object.writeToFile(plistPath(fileName), atomically: true)
  end

  # The object containing the data stored in the plist
  #
  # fileName - The name of the plist file to return, minus the .plist extension
  # klass    - The name of the Class which is being stored in the plist. Must be either a Hash or Array (defaults: Hash)
  #
  # Returns an Array or Hash with the file content
  def self.plistObject(fileName, klass = Hash)
    raise NoFileError, "Cannot find plist file: #{fileName}.plist in documents directory" unless exist?(fileName)
    path   = plistPath(fileName)
    if klass == Hash
      NSMutableDictionary.dictionaryWithContentsOfFile(path)
    elsif klass == Array
      NSMutableArray.arrayWithContentsOfFile(path)
    else
      raise ArgumentError, "Expected klass to be Array or Hash, was #{klass}"
    end
  end

  # Copy the template <fileName>.plist file from the resources dir to the application's documents directory
  # fileName - The name of the plist file to return, minus the .plist extension
  def self.copyPlistFileFromBundle(fileName)
    templatePath = NSBundle.mainBundle.pathForResource(fileName, ofType: 'plist')
    toPath       = plistPath(fileName)
    NSFileManager.defaultManager.copyItemAtPath(templatePath, toPath: toPath, error: nil)
  end
  
  private
  
  # Private: Helper method to access the application's documents directory
  def self.documentsDir
    @@documentsDir ||= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).first
  end
  
end