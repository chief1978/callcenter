FROM centos:centos7
LABEL maintainer='Anton Stukach <anton.stukach@gmail.com>'
ENV build_date 2023-06-12

RUN yum -y update \
    && yum -y groupinstall core base "Development Tools" \
    && yum -y install \
        epel-release \
        espeak \
        dmidecode \
        gcc-c++ \
        ncurses-devel \
        libxml2-devel \
        make \
        wget \
        openssl-devel \
        newt-devel \
        kernel-devel \
        sqlite-devel \
        libuuid-devel \
        libevent-devel \
        libtermcap-devel \
        readline-devel \
        gtk2-devel \
        jansson-devel \
        binutils-devel \
        libedit \
        libedit-devel \
        lua \
        sox \
        unixODBC \
        unixODBC-devel \
        python3 \
        python3-libs \
        python3-pip \
        python3-devel \
        python3-debug \
    && yum clean all \
    && pip3 install websocket-client \
    && cd /tmp \
    # Download and install mariaDB connector
    && cd ..  && mkdir odbc_package && cd odbc_package \
    && wget https://downloads.mariadb.com/Connectors/odbc/connector-odbc-3.1.7/mariadb-connector-odbc-3.1.7-ga-rhel7-x86_64.tar.gz \
    && tar -xvzf mariadb-connector-odbc-3.1.7-ga-rhel7-x86_64.tar.gz \
    && install lib64/libmaodbc.so /usr/lib64/ \
    && install -d /usr/lib64/mariadb/ \
    && install -d /usr/lib64/mariadb/plugin/ \
    && install lib64/mariadb/plugin/auth_gssapi_client.so /usr/lib64/mariadb/plugin/ \
    && install lib64/mariadb/plugin/caching_sha2_password.so /usr/lib64/mariadb/plugin/ \
    && install lib64/mariadb/plugin/client_ed25519.so /usr/lib64/mariadb/plugin/ \
    && install lib64/mariadb/plugin/dialog.so /usr/lib64/mariadb/plugin/ \
    && install lib64/mariadb/plugin/mysql_clear_password.so /usr/lib64/mariadb/plugin/ \
    && install lib64/mariadb/plugin/sha256_password.so /usr/lib64/mariadb/plugin/ \
    && cd /tmp \
    # Download and install lame
    && git clone https://github.com/zlargon/lame.git \
    && cd lame && ./configure && make && make install \
    && cd /tmp \    
    # Download asterisk
    && git clone -b 13.26 https://gerrit.asterisk.org/asterisk \
    && cd asterisk/contrib/scripts \
    && ./install_prereq install \
    && ./install_prereq install-unpackaged \
    && cd ../.. \
    && contrib/scripts/get_mp3_source.sh \
    # make asterisk
    # Configure
    && ./configure --with-pjproject-bundled --with-jansson-bundled --libdir=/usr/lib64 1> /dev/null \
    # Remove the native build option add some options
    && make -j$(nproc) menuselect.makeopts \
    && menuselect/menuselect \
                          --disable BUILD_NATIVE \
                          --enable cdr_csv \
                          --enable chan_sip \
                          --enable res_snmp \
                          --enable res_http_websocket \
                          --enable format_mp3 \
                          --enable CORE-SOUNDS-RU-WAV \
                          --enable CORE-SOUNDS-RU-ULAW \
                          --enable CORE-SOUNDS-RU-ALAW \
                          --enable CORE-SOUNDS-RU-GSM \
                      menuselect.makeopts \
    # Continue with a standard make
    && make -j$(nproc) 1> /dev/null \
    && make -j$(nproc) install 1> /dev/null \
    && make -j$(nproc) install-logrotate 1> /dev/null \    
    # clean up the cached make files
    && make dist-clean \
    # Update max number of open files
    && sed -i -e 's/# MAXFILES=/MAXFILES=/' /usr/sbin/safe_asterisk \
    # Set tty
    && sed -i 's/TTY=9/TTY=/g' /usr/sbin/safe_asterisk \
    # Set se
    && sed -i 's/enforcing/permissive/' /etc/sysconfig/selinux \
    # && setenforce 0 \
    # Create and configure asterisk for running asterisk user
    && useradd -m asterisk -s /sbin/nologin \
    && chown -R asterisk:asterisk /var/run/asterisk \
                                  /etc/asterisk/ \
                                  /var/lib/asterisk \
                                  /var/log/asterisk \
                                  /var/spool/asterisk \
                                  /usr/lib64/asterisk/ \
    && make \
    && make install
# Running asterisk with user asterisk
USER asterisk
CMD /usr/sbin/asterisk -fvvvvv
