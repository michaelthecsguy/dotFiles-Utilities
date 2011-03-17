require 'uri'
require 'yaml'
require 'fileutils'

module GitSvnSync
  class Svn
    attr_reader :svn_dir

    class << self
      def verify_url_exists(url)
        raise StandardError.new("Error accessing #{url}, are you sure it exists?") unless exists?(url)
      end

      def exists?(url)
        GitSvnSync.verbose_execute "svn info #{url}", false, :on_error => :do_nothing

        $? == 0
      end

      def create_branch(base_branch_url, new_branch)
        GitSvnSync.verbose_execute "svn copy -m 'Creating new branch for syncing from git repository' #{base_branch_url} #{new_branch}"
      end

      def new_branch_name(base_branch_url, branch_name)
        # Remove trailing slash
        base_branch_url = base_branch_url.chomp('/')

        unless base_branch_url =~ %r{/((branches|tags)/[^/]+|trunk)$}
          raise StandardError.new('Error creating new branch: svn url must end with "branches/*", "tags/*", or "trunk"')
        end

        new_branch = [Regexp.last_match.pre_match, "branches", branch_name].join('/')
      end
    end

    # Checkout the svn repo at svn_url to svn_dir
    def initialize(svn_url, svn_dir)
      @svn_url = svn_url
      @svn_dir = svn_dir
    end

    def made_changes?
      @made_changes
    end

    def checkout
      svn_command = "svn checkout #{@svn_url} #{@svn_dir}"
      puts "Executing '#{svn_command}'" if $VERBOSE

      execute_with_progress("Checking out #{@svn_url}", svn_command)

      puts "Exit status: #{$?.to_i}" if $VERBOSE
    end

    def switch
      svn_command = "cd #{@svn_dir}; svn switch #{@svn_url}"
      puts "Executing '#{svn_command}'" if $VERBOSE

      execute_with_progress("Switching to #{@svn_url}", svn_command)

      puts "Exit status: #{$?.to_i}" if $VERBOSE
    end

    def revert_all
      svn_command = "cd #{@svn_dir}; svn revert -R ."
      puts "Executing '#{svn_command}'" if $VERBOSE

      execute_with_progress("Reverting #{@svn_url}", svn_command)

      puts "Exit status: #{$?.to_i}" if $VERBOSE

      untracked_files = GitSvnSync.verbose_execute("cd #{@svn_dir}; svn status", true)

      error_lines = []
      to_remove = []

      untracked_files.each_line do |line|
        line.chomp!
        if line =~ /^\?[ \t]+(.*)$/
          to_remove << $1
        else
          error_lines << line
        end
      end

      if to_remove && !to_remove.empty?
        puts "Removing the following files: #{to_remove.join(' ')}" if $VERBOSE
        FileUtils.rm_rf(to_remove.map{|f| File.join(@svn_dir, f)})
      end

      puts "Error Lines:\n#{error_lines.join("\n")}" if !error_lines.empty? && $VERBOSE
      raise StandardError.new("Couldn't revert all changes in #{@svn_dir}, changes remain:\n#{error_lines.join("\n")}") unless error_lines.empty?
    end

    def execute_with_progress(message, command)
      print "#{message}..."

      IO.popen(command) do |f|
        line_count = 0
        dot_frequency = 1
        dot_count = 0

        while(f.gets)
          line_count += 1

          if line_count % dot_frequency == 0
            print "."
            dot_count += 1
            dot_frequency += 1 if dot_count > dot_frequency**2
          end
        end
      end

      puts "done."
    end

    def local_changes?
      GitSvnSync.verbose_execute("cd #{@svn_dir}; svn status 2>&1", true) != ''
    end

    def wrong_branch?
      output = GitSvnSync.verbose_execute("cd #{@svn_dir}; svn info 2>&1", true)

      YAML.load(output)['URL'] != @svn_url
    end

    def nuke_project
      @made_changes = true

      print "Cleaning out svn files..."
      delete_project_files(@svn_dir)
      puts "done."
    end

    def add_delete
      @made_changes = true

      add_files = []
      delete_files = []

      IO.popen("cd #{@svn_dir}; svn status") do |f|
        while (line=f.gets)
          line.chomp!

          if line =~ /^\?/
            add_files << line.split(/ +/)[1]
          elsif line =~ /^!/
            delete_files << line.split(/ +/)[1]
          end
        end
      end

      while !add_files.empty?
        # Do a small group at a time so we don't go over the arg length limit
        files_to_add = add_files.slice!(0, 100)

        GitSvnSync.verbose_execute "cd #{@svn_dir}; svn add #{files_to_add.join(' ')}"
      end

      while !delete_files.empty?
        # Do a small group at a time so we don't go over the arg length limit
        files_to_delete = delete_files.slice!(0, 100)

        GitSvnSync.verbose_execute "cd #{@svn_dir}; svn rm #{files_to_delete.join(' ')}"
      end
    end

    def commit(message)
      changes = GitSvnSync.verbose_execute("cd #{@svn_dir}; svn status", true)

      if changes.empty?
        puts "No changes to commit."
      else
        puts "The following changes will be made to #{@svn_url}:"
        puts changes
        puts "Commit message: #{message}"

        print "Are you sure you want to commit these changes (enter yes to commit)? "
        answer = gets

        if answer && answer.chomp.downcase == 'yes'
          puts GitSvnSync.verbose_execute("cd #{@svn_dir}; svn commit -m '#{message}'", true)
        else
          puts "Commit aborted"
        end
      end
    end

    def delete_project_files(dir)
      @made_changes = true

      files = []
      Dir.foreach(dir) do |entry|
        full_path = File.join(dir, entry)

        if File.directory?(full_path) && !File.symlink?(full_path)
          delete_project_files(full_path) unless entry =~ /^\.\.?$/ || entry == '.svn'
        else
          files << full_path
        end
      end

      File.delete(*files) unless files.empty?
    end
  end
end
