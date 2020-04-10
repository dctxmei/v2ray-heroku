#!/bin/sh

# Download and install V2Ray
mkdir /tmp/v2ray/
curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip https://github.com/v2ray/v2ray-core/releases/latest/download/v2ray-linux-64.zip
unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray/
install -m 755 /tmp/v2ray/v2ray /usr/local/bin/v2ray
install -m 755 /tmp/v2ray/v2ctl /usr/local/bin/v2ctl

# Remove temporary directory
rm -r /tmp/v2ray/

# V2Ray new configuration
install -d /usr/local/etc/v2ray/
echo '{' | tee /usr/local/etc/v2ray/config.json
echo '    "inbounds": [' | tee -a /usr/local/etc/v2ray/config.json
echo '        {' | tee -a /usr/local/etc/v2ray/config.json
echo '            "port": "env:PORT",' | tee -a /usr/local/etc/v2ray/config.json
echo '            "protocol": "vmess",' | tee -a /usr/local/etc/v2ray/config.json
echo '            "settings": {' | tee -a /usr/local/etc/v2ray/config.json
echo '                "clients": [' | tee -a /usr/local/etc/v2ray/config.json
echo '                    {' | tee -a /usr/local/etc/v2ray/config.json
echo '                        "id": "$UUID"' | tee -a /usr/local/etc/v2ray/config.json
echo '                    }' | tee -a /usr/local/etc/v2ray/config.json
echo '                ]' | tee -a /usr/local/etc/v2ray/config.json
echo '            },' | tee -a /usr/local/etc/v2ray/config.json
echo '            "streamSettings": {' | tee -a /usr/local/etc/v2ray/config.json
echo '                "network": "ws"' | tee -a /usr/local/etc/v2ray/config.json
echo '            }' | tee -a /usr/local/etc/v2ray/config.json
echo '        }' | tee -a /usr/local/etc/v2ray/config.json
echo '    ],' | tee -a /usr/local/etc/v2ray/config.json
echo '    "outbounds": [' | tee -a /usr/local/etc/v2ray/config.json
echo '        {' | tee -a /usr/local/etc/v2ray/config.json
echo '            "protocol": "freedom"' | tee -a /usr/local/etc/v2ray/config.json
echo '        }' | tee -a /usr/local/etc/v2ray/config.json
echo '    ]' | tee -a /usr/local/etc/v2ray/config.json
echo '}' | tee -a /usr/local/etc/v2ray/config.json

# Run V2Ray
/usr/local/bin/v2ray -config /usr/local/etc/v2ray/config.json
