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

echo "[listenerConfig]
host=\"0.0.0.0\"
httpPort=9090
httpsPort=9095
keyStorePath=\"\${ballerina.home}/bre/security/ballerinaKeystore.p12\"
keyStorePassword=\"ballerina\"
trustStorePath=\"\${ballerina.home}/bre/security/ballerinaTruststore.p12\"
trustStorePassword=\"ballerina\"
tokenListenerPort=9096

[keyManager]
  serverUrl = \"https://${host_ip}:9443\"
  tokenContext = \"oauth2\"
  external = false
  [keymanager.security.basic]
    enabled = true
    username = \"admin\"
    password = \"admin\"

[[jwtTokenConfig]]
  issuer = \"https://localhost:9443/oauth2/token\"
  certificateAlias = \"wso2apim310\"
  validateSubscription = true
  consumerKeyClaim = \"aud\"

[analytics]
  [analytics.fileUpload]
    enable = false

[b7a.users]
  [b7a.users.admin]
    password = \"d033e22ae348aeb5660fc2140aec35850c4da997\"

[httpClients]
  verifyHostname = false

[apikey.issuer]
  [apikey.issuer.tokenConfig]
    enabled = true
    issuer = \"https://localhost:9095/apikey\"
    certificateAlias = \"ballerina\"
    validityTime = -1

# Throttling configurations
[throttlingConfig]
  enabledGlobalTMEventPublishing = false
  jmsConnectionProviderUrl = \"amqp://admin:admin@carbon/carbon?brokerlist='tcp://${host_ip}:5672'\"
  # Throttling configurations related to event publishing using a binary connection
  [throttlingConfig.binary]
    enabled = true
    [[throttlingConfig.binary.URLGroup]]
      receiverURL = \"tcp://${host_ip}:9611\"
      authURL = \"ssl://${host_ip}:9711\"

[apim.eventHub]
  enable = true
  serviceUrl = \"https://${host_ip}:9443\"
  internalDataContext=\"/internal/data/v1/\"
  username=\"admin\"
  password=\"admin\"
  eventListeningEndpoints = \"amqp://admin:admin@carbon/carbon?brokerlist='tcp://${host_ip}:5672'\"

[security]
  validateSubscriptions = true" > micro-gw.conf