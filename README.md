# serverspec.role.nginx
ServerSpec role for testing NGINX configurations.

At the moment the structure of this repo is a little out of wack as it includes the Dockerfile that was used to develop the role.

# Pre-requisites
1. ServerSpec 2 or higher.
2. Rake 0.9.6 or higher.

# Usage
1. Run `serverspec-init` to create a new serverspec test project.
2. Create the following directory inside your serverspec project - `./spec/roles'
3. Navigate to the new directory, add the nginx role as a git sub module and initialise the submodule.
 ```
cd spec/roles
git submodule add https://github.com/nathonfowlie/serverspec.role.nginx.git
git submodule init
```

4. Create a file called `properties.yml` back in your main project directory. This will hold the configuration information used by the nginx role. Refer to `spec/roles/nginx/properties.yml.example` for the list of available configuration parameters.
