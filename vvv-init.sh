# Init script for VVV

name=etp
db=${name}
url=${name}.dev

echo "Commencing ${name} Setup"

# Make a database, if we don't already have one
echo "Creating database (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS ${db}"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON ${db}.* TO wp@localhost IDENTIFIED BY 'wp';"

# Download WordPress
if [ ! -d htdocs ]
then
	echo "Installing WordPress using WP CLI"
	mkdir htdocs
	cd htdocs
	wp core download 
	wp core config --dbname="${db}" --dbuser=wp --dbpass=wp --dbhost="localhost"
	wp core install --url=${url} --title="${name} dev site" --admin_user=admin --admin_password=password --admin_email=matt@antym.com
	cd ..
fi

# The Vagrant site setup script will restart Nginx for us

echo "${name} site now installed";
