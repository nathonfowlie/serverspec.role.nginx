module Nginx
	# Helper class that is used to load NGINX configuration details from
	# properties.yaml, falling back to default values where the user has not
	# provided any configuration information.
	#
	# Author: Nathon Fowlie (mailto: nathon.fowlie@gmail.com)
	# Copyright:
	# License: Distributes under the same terms as Ruby.
    class Configuration
        DEFAULT_USER        = 'nginx';
        DEFAULT_GROUP       = 'nginx';
        DEFAULT_LOG_DIR     = '/mnt/logs/nginx';
        DEFAULT_INSTALL_DIR = '/etc/nginx';
        DEFAULT_LOG_FORMAT  = '\$remote_addr - \$remote_user \[\$time_local\] \"\$request\" \$status \$body_bytes_sent \"\$http_referer\" \"\$http_user_agent\" \"\$http_x_forwarded_for\"';

		# Parse the user specified configuration options and fallback to defaults 
		# where necessary.
		#
		# Params:
		# +properties+:: YAML structure which contains the nginx configuration 
		# information.
        def initialize(properties)
            @user = properties[:nginx_user] || DEFAULT_USER;
            @group = properties[:nginx_group] || DEFAULT_GROUP;

			@log_dir = properties[:nginx_log_dir] || DEFAULT_LOG_DIR;
            @install_dir = properties[:nginx_install_dir] || DEFAULT_INSTALL_DIR;

			@log_format = properties[:nginx_log_format] || DEFAULT_LOG_FORMAT;
			
			@version = properties[:nginx_version];
        end

		# Get the group that should own the nginx installation directory
		# and log directories.
        def group()
            return @group;
        end

		# Get the nginx installation directory.
        def install_dir()
            return @install_dir;
        end

		# Get the log directory that the standard nginx access and error
		# logs should be written to.
        def log_dir()
            return @log_dir;
        end

		# Get the 'main' log format used by nginx.
        def log_format()
            return @log_format;
        end

		# Get the user that the nginx service should run under.
        def user()
            return @user;
        end
		
		# Get the nginx version that is required to be installed.
        def version()
            return @version;
        end
    end
end