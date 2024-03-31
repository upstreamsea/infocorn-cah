#!/bin/bash

scriptinfo(){
    output "InfoCorn Installer"
    output "This will configure and setup a InfoCorn server automatically."
    output "The following packages will be installed: software-properties-common, apt-transport-https, gnupg, git, curl, sudo, openjdk-8-jdk, maven.\n"
}

options(){
    output "Please select an option below.\n\n[1] Install InfoCorn.\n[2] Install and Activate cloudflared.\n"
    read choice
    case $choice in
    1 ) option=1
    output "Installing on a fresh system."
    ;;
    2 ) option=2
    output "Installing Cloudflare Tunnel."
    ;;
    * ) output "Invalid option selected."
    options
    
    esac
}

fresh_install(){
    output "Updating and Upgrading APT packages, please wait..."
    apt-get update
    apt-get upgrade -y

    output "Installing APT dependencies, please wait..."
    apt-get install software-properties-common apt-transport-https gnupg git curl sudo -y

    output "Installing OpenJDK 8, please wait...."
    mkdir -o /etc/apt/keyrings
    wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc
    echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list
    apt-get update
    apt-get install -y temurin-8-jdk

    output "Installing Maven."
    mkdir -p /usr/share/maven
    wget -O /tmp/maven.tar.gz https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.5.4/apache-maven-3.5.4-bin.tar.gz
    tar -xzf /tmp/maven.tar.gz -C /usr/share/maven --strip-components=1
    rm -f /tmp/maven.tar.gz
    ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

    output "Downloading the latest InfoCorn from https://github.com/upstreamsea/infocorn-cah."
    git clone -b main https://github.com/upstreamsea/infocorn-cah.git /home/infocorn/infocorn

        cat > /home/infocorn/infocorn-autorun.sh <<- 'EOF'
#!/bin/bash
cd /home/infocorn/infocorn
if [[ ! -f "build.properties" ]]; then
    mv build.properties.example build.properties
fi
mvn clean package war:exploded jetty:run -Dhttps.protocols=TLSv1.2 -Dmaven.buildNumber.doCheck=false -Dmaven.buildNumber.doUpdate=false
EOF
}

buildpropertieschoice(){
    output "Would you like to define a location for a current build.properties file?\n[1]Yes, the build.properties is local on the system.\n[2]Yes, download the build.properties file.\n[3]No, generate a new one."
    read buildpropertieschoice
    case $buildpropertieschoice in
    1 ) bpcoption=1
    output "Where is your build.properties on the machine? Please give a full file path e.g. /usr/local/sbin/build.properties"
    read bpwherelocal
    ;;
    2 ) bpcoption=2
    output "Where is your build.properties located on the internet? Please give a curlable link. e.g. https://bing.com/random/build.properties"
    read bpwhereweb
    ;;
    3 ) bpcoption=3
    output "Moving build.properties.example to build.properties"
    ;;
    * ) output "Invalid option selected."
    options
    
    esac
}

buildproperties(){
    if [ "$bpcoption" = "1" ]; then
        mv "$bpwherelocal" /home/infocorn/infocorn/build.properties
        rm -f /home/infocorn/infocorn/build.properties.example
    elif [ "$bpcoption" = "2" ]; then
        wget -O /home/infocorn/infocorn/build.properties "$bpwhereweb"
        rm -f /home/infocorn/infocorn/build.properties.example        
    fi
}

systemdshit(){
    output "Configuring systemd service: infocorn.service"

    cat > /lib/systemd/system/infocorn.service <<- 'EOF'
[Unit]
Description="InfoCorn CAH"
After=syslog.target

[Service]
User=infocorn
Restart=always
RestartSec=5
ExecStart=/home/infocorn/infocorn-autorun.sh

[Install]
WantedBy=multi-user.target
EOF

    chmod +x /home/infocorn/infocorn-autorun.sh
    adduser --disabled-password --shell /bin/bash --gecos "InfoCorn" infocorn
    chown -R infocorn:infocorn /home/infocorn
    systemctl enable infocorn.service
    systemctl start infocorn.service
}

cloudflare_tunnel_key(){
    output "Under 'Install and run a connector', copy and paste the 'If you already have cloudflared installed on your machine' command."
    read cfkey
}

cloudflare_tunnel(){
    output "Installing Cloudflared."
    curl -L --output /tmp/cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
    dpkg -i /tmp/cloudflared.deb
    rm -f /tmp/cloudflared.deb

    output "Activating Cloudflared."
    $cfkey
}

#Execution
scriptinfo
options
case $option in
    1 ) fresh_install
        buildpropertieschoice
        buildproperties
        systemdshit
        ;;
    2 ) cloudflare_tunnel_key
        cloudflare_tunnel
        ;;
esac