
script "install_something" do
  interpreter "bash"
  user "bommurevathi"
  cwd "/home/Boomu Revathi/"
  code <<-EOH

lsb_release -d >> ver
lsb_ver=`cat ver`
PARTS=(${lsb_ver//:/ })
lsb_ver=${PARTS[1]}
rm ver

ruby --version &> localver
local=`cat localver`
PART=(${local// / }) #The ${VARIABLE//./ } expansion changes all . to spaces and then it's split on word boundaries into an array.
local=${PART[0]}" "${PART[1]}
rm localver

needed="ruby 2.0.0"

if [[ $needed != $local ]]
then
	rvm -v &> rv.tx
	rv=`cat rv.tx`
	PARTS=(${rv// / })
	rv=${PARTS[0]}
	rm rv.tx
	needr="rvm"
	if [[ $needr != $rv ]]
	then
		\curl -sSL https://get.rvm.io | bash
	fi
	rvm install 2.0.0
	rvm use 2.0.0
else
	printf "Ruby is Installed\n"
fi

echo $local

echo $lsb_ver


repo="https://github.com/dchealthlink/MITC.git"

git clone $repo

cd MITC
rvm use 2.0.0
sudo apt-get install bundler
gem install bundler
bundle install
rake db:create
rake db:schema:load


  EOH
end
