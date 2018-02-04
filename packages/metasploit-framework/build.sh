TERMUX_PKG_HOMEPAGE=https://www.metasploit.com/
TERMUX_PKG_DESCRIPTION="framework for pentesting"
TERMUX_PKG_VERSION=4.16.2
TERMUX_PKG_SRCURL=https://github.com/rapid7/metasploit-framework/archive/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=564072e633da3243252c3eb2cd005e406c005e0e4bbff56b22f7ae0640a3ee34
TERMUX_PKG_FOLDERNAME=metasploit-framework-$TERMUX_PKG_VERSION
TERMUX_PKG_DEPENDS="ruby, autoconf, bison, clang, coreutils, apr, apr-util, libffi-dev, libgmp-dev, libpcap-dev, postgresql-dev, readline-dev, libsqlite-dev, openssl-dev, libtool, libxml2-dev, libxslt-dev, ncurses-dev, pkg-config, postgresql-contrib, make, ruby-dev, libgrpc-dev, termux-tools, ncurses, ncurses-utils, libsodium-dev"
TERMUX_PKG_BUILD_IN_SRC=yes

termux_step_configure () {
	return
}

termux_step_post_extract_package () {

        sudo apt-get install -y ruby ruby-dev make cmake automake
        #mkdir $TERMUX_PREFIX/lib/ruby/include
        #ln -s $TERMUX_PREFIX/include/ruby-2.4.0/ruby.h $TERMUX_PREFIX/lib/ruby/include/
        #ln -s $TERMUX_PREFIX/include/ruby-2.4.0/ruby.h /usr/lib/ruby/include/
        #$TERMUX_HOME/.rvm/scripts/rvm use 2.4.0
        #SetEnv GEM_HOME $TERMUX_PREFIX/lib/ruby/gems/2.4.0
        gem install --install-dir $TERMUX_PREFIX/lib/ruby/gems/2.4.0 bundler -v 1.15.4
	
        #gem install --install-dir $TERMUX_PREFIX/lib/ruby/gems/2.4.0 nokogiri -- --use-system-libraries --ruby=$TERMUX_PREFIX/bin/ruby2.3
        echo $TERMUX_PKG_SRCDIR
        cd $TERMUX_PKG_SRCDIR
		sed 's|git ls-files|find -type f|' -i metasploit-framework.gemspec
		sed 's/rb-readline  (0.5.5)/rb-readline /g' -i Gemfile.lock
		sed 's/rb-readline/rb-readline (= 0.5.5)/g' -i Gemfile.lock
	
		sed '/rbnacl/d' -i Gemfile.lock
		sed '/rbnacl/d' -i metasploit-framework.gemspec     
	
        #bundler comes in... 
		cd $TERMUX_PKG_SRCDIR
        #$TERMUX_PREFIX/lib/ruby/gems/2.4.0/gems/bundler-1.15.4/exe/bundle install --path=$TERMUX_PREFIX/lib/ruby/gems/2.4.0 -j5
        #ln -s $TERMUX_PREFIX/lib/ruby/gems/2.4.0/gems/bundler-1.15.4/exe/bundle $TERMUX_PREFIX/bin
        #install dependency gems
        #export GEM_HOME $TERMUX_PREFIX/lib/ruby/gems/2.4.0
        #export GEM_PATH $TERMUX_PREFIX/lib/ruby/gems/2.4.0
	
        
        #cd /usr/lib/ruby/include/
        #ls
        #manual gem installation ( as bundler fails ) 
		curl -LO https://Auxilus.github.io/gemdeps
        #while IFS='' read -r line || [[ -n "$line" ]]; do
        #      echo "Installing $line \n"
        #      gem install --install-dir $TERMUX_PREFIX/lib/ruby/gems/2.4.0 $line
        #done < "gemdeps"
        while read p; do
            echo "installing $p" 
            gem install --install-dir $TERMUX_PREFIX/lib/ruby/gems/2.4.0 $p
        done < gemdeps
	
        #bundle install --path=$GEM_PATH --gemfile=Gemfile
        #symlink msfconsole to $PREFIX/bin
        #ln -s $TERMUX_PKG_SRCDIR/msfconsole $TERMUX_PREFIX/bin/
        cd $TERMUX_PREFIX/bin
        ls
}

termux_step_make_install () {
	return
}
