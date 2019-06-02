#!/bin/bash
# Copyright 2019 WSO2 Inc. (http://wso2.org)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# ----------------------------------------------------------------------------
# Start WSO2 API Manager Micro Gateway Configuration
# ----------------------------------------------------------------------------
while getopts "i:" opt; do
    case "${opt}" in
    i)
        host_ip=${OPTARG}
        ;;
    esac
done

if [[ -z $host_ip ]]; then
    echo "Please provide the host ip for create-micro-gw.sh"
    exit 1
fi
touch /home/ubuntu/echo-mgw/target/micro-gw.conf
chmod a+rw /home/ubuntu/echo-mgw/target/micro-gw.conf

echo "[listenerConfig]
host=\"0.0.0.0\"
httpPort=9090
httpsPort=9095
keyStore.path=\"\${ballerina.home}/bre/security/ballerinaKeystore.p12\"
keyStore.password=\"ballerina\"
trustStore.path=\"\${ballerina.home}/bre/security/ballerinaTruststore.p12\"
trustStore.password=\"ballerina\"
tokenListenerPort=9096

[authConfig]
authorizationHeader=\"Authorization\"
removeAuthHeaderFromOutMessage=true

[keyManager]
serverUrl=\"${host_ip}\"
username=\"admin\"
password=\"admin\"
tokenContext=\"oauth2\"
timestampSkew=5000


[jwtTokenConfig]
issuer=\"${host_ip}/oauth2/token\"
audience=\"http://org.wso2.apimgt/gateway\"
certificateAlias=\"wso2apim\"


[jwtConfig]
header=\"X-JWT-Assertion\"

[caching]
enabled=true
tokenCache.expiryTime=900000
tokenCache.capacity=10000
tokenCache.evictionFactor=0.25

[analytics]
enable=false
uploadingTimeSpanInMillis=600000
uploadingEndpoint=\"${host_ip}/analytics/v1.0/usage/upload-file\"
rotatingPeriod=600000
task.uploadFiles=true
username=\"admin\"
password=\"admin\"

[http2]
enable=false

[mutualSSLConfig]
protocolName=\"TLS\"
protocolVersions=\"TLSv1.2,TLSv1.1\"
ciphers=\"TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDH_ECDSA_WITH_AES_128_CBC_SHA256,TLS_ECDH_RSA_WITH_AES_128_CBC_SHA256,TLS_DHE_RSA_WITH_AES_128_CBC_SHA256,TLS_DHE_DSS_WITH_AES_128_CBC_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_AES_128_CBC_SHA,TLS_ECDH_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDH_RSA_WITH_AES_128_CBC_SHA,TLS_DHE_RSA_WITH_AES_128_CBC_SHA,TLS_DHE_DSS_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDH_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDH_RSA_WITH_AES_128_GCM_SHA256,TLS_DHE_RSA_WITH_AES_128_GCM_SHA256,TLS_DHE_RSA_WITH_AES_128_GCM_SHA256,TLS_DHE_DSS_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_3DES_EDE_CBC_SHA,TLS_ECDHE_RSA_WITH_3DES_EDE_CBC_SHA,SSL_RSA_WITH_3DES_EDE_CBC_SHA,TLS_ECDH_ECDSA_WITH_3DES_EDE_CBC_SHA,TLS_ECDH_RSA_WITH_3DES_EDE_CBC_SHA,SSL_DHE_RSA_WITH_3DES_EDE_CBC_SHA,SSL_DHE_DSS_WITH_3DES_EDE_CBC_SHA,TLS_EMPTY_RENEGOTIATION_INFO_SCSV\"
sslVerifyClient=\"not_require\"

[\"b7a.users\"]
[\"b7a.users.generalUser1\"]
password=\"5BAA61E4C9B93F3F0682250B6CF8331B7EE68FD8\"

[validationConfig]
enableRequestValidation=false
enableResponseValidation=false
absolutePathToSwagger=\"\"


[throttlingConfig]
enabledGlobalTMEventPublishing=false
jmsConnectioninitialContextFactory=\"bmbInitialContextFactory\"
jmsConnectionProviderUrl=\"amqp://admin:admin@carbon/carbon?brokerlist='tcp://localhost:5672'\"
jmsConnectionUsername=\"\"
jmsConnectionPassword=\"\"
throttleEndpointUrl=\"${host_ip}/endpoints\"
throttleEndpointbase64Header=\"admin:admin\"

[tokenRevocationConfig]
  [tokenRevocationConfig.realtime]
    enableRealtimeMessageRetrieval=false
    jmsConnectionTopic=\"tokenRevocation\"
    jmsConnectioninitialContextFactory=\"bmbInitialContextFactory\"
    jmsConnectionProviderUrl=\"amqp://admin:admin@carbon/carbon?brokerlist='tcp://localhost:5672'\"
    jmsConnectionUsername=\"\"
    jmsConnectionPassword=\"\"
  [tokenRevocationConfig.persistent]
    enablePersistentStorageRetrieval=false
    useDefault=true
    hostname=\"https://127.0.0.1:2379/v2/keys/jti/\"
    username=\"root\"
    password=\"root\"

[httpClients]
  verifyHostname=true" > /home/ubuntu/echo-mgw/target/micro-gw.conf
