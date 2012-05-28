require 'active_support/core_ext/array/extract_options'
module EasyDownloader
  class Options
    attr_accessor :files, :successful, :result, :load_count, :type,
                  :host, :user, :password,
                  :local_path, :remote_path,
                  :local_pattern, :remote_pattern,
                  :local_file, :remote_file, :last_file, :redownload_last

    def initialize(*options)
      @files = []
      @successful      = false
      @result          = Result.new
      @load_count = 0
      @options = options
      @options_back = options.dup

      options.extract_options!.each do |key, value|
        send("#{key}=".to_sym, value) if respond_to?("#{key}=".to_sym)
      end
    end

    def remote_path
      to_dir_path(@remote_path)
    end

    def local_path
      to_dir_path(@local_path)
    end

    def to_dir_path(path)
      if path
        path =~ /\/$/ ?  path : path + '/'
      else
        ''
      end
    end
    
    def inspect
      @options_back.extract_options!
    end
    def to_s
      inspect.to_s
    end
  end
end
