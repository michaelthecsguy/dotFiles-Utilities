require 'git_svn_sync/git'
require 'git_svn_sync/svn'
require 'tmpdir'
require 'optparse'

module GitSvnSync
  module Command
    class << self
      def run
        options = parse_options

        # Make sure all the "print" statements without newlines get flushed immediately by default
        $stdout.sync = true

        begin
          unless svn_url = ARGV.shift
            puts "You must provide an svn target url!"
            exit 1
          end

          git_tree = ARGV.shift || GitSvnSync.verbose_execute("git name-rev --name-only HEAD 2>/dev/null", true).chomp

          # Verify that we're in a git repository with the tree-ish object specified
          Git.verify_treeish(git_tree)

          Svn.verify_url_exists(svn_url)

          svn_dest_url = if options[:branch]
                           new_branch = Svn.new_branch_name(svn_url, options[:branch])

                           unless Svn.exists?(new_branch)
                             Svn.create_branch(svn_url, new_branch)
                           end

                           new_branch
                         else
                           svn_url
                         end

          if options[:directory]
            svn = Svn.new(svn_dest_url, options[:directory])

            raise StandardError.new("There are local changes in #{svn.svn_dir}, aborting!") if svn.local_changes?

            # Switch also doubles as an svn update in the event that we have the right branch but it's out of date.
            svn.switch

            raise StandardError.new("Something went wrong with the svn_switch (see svn status and svn info output)") if svn.local_changes? || svn.wrong_branch?
          else
            tmpdir = Dir.mktmpdir
            svndir = File.join(tmpdir, 'git_svn_sync_svn_dir')
            svn = Svn.new(svn_dest_url, svndir)
            svn.checkout
          end

          # Blow away everything except .svn
          svn.nuke_project

          # Put the git archive in place
          Git.export_project(git_tree, svn.svn_dir)

          # Figure out what to svn add and svn delete
          svn.add_delete

          message = Git.construct_commit_message(git_tree)

          # Commit the new state
          svn.commit(message)
        rescue StandardError => e
          puts "Aborted: #{e.message}"
          raise if $VERBOSE
        rescue Interrupt
          puts "Interrupted!"
          raise if $VERBOSE
        ensure
          if options[:clean]
            if tmpdir
              print "Removing temp directory..."
              FileUtils.remove_entry_secure tmpdir
              puts "done."
            else
              # Clean up in case there was a problem
              svn.revert_all if svn && svn.made_changes? && svn.local_changes?
            end
          end
        end
      end

      def parse_options
        options = {:clean => true}

        opts = OptionParser.new do |opts|
          opts.banner = "Usage: git-svn-sync [options] SVN_TARGET_URL [GIT_VERSION]"

          opts.separator ""
          opts.separator "Specific options:"

          opts.on("-b", "--branch BRANCHNAME",
                  "Create a new svn branch in branches/BRANCHNAME for the export") do |branch|
            options[:branch] = branch
          end

          opts.on("-d", "--directory PATH",
                  "Use the svn repository found in PATH.", "An svn switch will be performed on PATH, which must have no local changes.") do |directory|
            options[:directory] = directory
          end

          opts.on("--no-clean",
                  "Don't clean up/remove temporary directory, or revert svn directory.") do |clean|
            options[:clean] = clean
          end

          opts.on("-v", "--verbose", "Run verbosely") do |v|
            $VERBOSE = v
          end

          opts.separator ""
          opts.separator "Common options:"

          opts.on_tail("-h", "--help", "Show this message") do
            puts opts
            exit
          end
        end

        opts.parse!(ARGV)

        options
      end
    end
  end
end
