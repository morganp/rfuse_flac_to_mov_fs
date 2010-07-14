require "rubygems"
require 'fusefs'
require 'rfuse_flac_to_mov_fs_opts'
require 'pp'

class RFuseFlacToMovFS
   # contents( path )
   # file?( path )
   # directory?( path )
   # read_file( path )
   # size( path )
   # 
   # save
   # touch( path )
   # can_write?(path)
   # write_to(path,body)
   # 
   # can_delete?(path)
   # delete( path )
   #
   # can_mkdir?( path )
   # mkdir( path )
   # can_rmdir( path )
   # rmdir( path )
   # 



   def initialize( options )
      puts "#{__FILE__} initialize( #{options.input} )"
      @base_dir = options.input
   end

   def contents(path)
      n_path = File.expand_path( @base_dir + path )
      Dir.chdir(n_path)  

      # TODO 
      # Currently just return a list of files we need to search and replace /.flac$/.mov/i

      files = Dir.glob('*')
      #Added command to OS X Finder not to index.
      files << 'metadata_never_index'

      # incase esensitive match
      files.each do |x|
         x.gsub!(/\.flac$/i, ".mov")
      end

      return files
   end
  
   def file?(path)
      #If path ends with metadata_never_index it is a file
      if path =~ /metadata_never_index$/
         return true
      end

      #Need method which checks for .flac or jut not directory and everuthing is a file

      return (not File.directory?( @base_dir + path ))
   end

   def directory?(path)
      File.directory?(@base_dir + path)
   end
  
   def read_file(path)
      input = path.dup
      
      if File.exists?( @base_dir + input)
         return File.new(@base_dir + input , "r").read
      end
      
      # mmm replacment was not case sensitive so we do not actuallt
      #   know the correct case of the file extension
      #   NB:  the most popular format of HFS+ (mac drives) is not case sensitive
      #   so these should resolve correctly for now
      if input =~ /\.mov$/ 
         input['.mov'] = '.flac'
      end
      #puts "read file #{path}"
      if File.exists?( @base_dir + input)
         return File.new(@base_dir + input , "r").read
      end

      return "ERROR, file not found\n"

   end


   def size(path)
        puts "size( #{path}"
      input = path.dup
      if input =~ /\.mov$/
         puts "   Converting from mov to flac"
         input['.mov'] = '.flac'
      end

      
      if File.exists?( @base_dir + input )
         return File.size( @base_dir + input )
      else
         return 16
      end
   end
end


if $0 == __FILE__

   options = RFuseFlacToMovFSOpts.parse(ARGV)
   filesystem = RFuseFlacToMovFS.new( options )
   FuseFS.set_root( filesystem )

   FileUtils.mkdir_p( options.mountpoint ) 

   # Mount under a directory given on the command line.
   FuseFS.mount_under options.mountpoint
   FuseFS.run
end

