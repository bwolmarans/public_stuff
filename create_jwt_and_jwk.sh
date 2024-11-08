#!/bin/bash
#
# create_jwt_and_jwk.sh
# ---------------------
#
# purpose: creates a jwt and jwk based on Liam's blog
# credit : Liam's blog https://www.f5.com/company/blog/nginx/authenticating-api-clients-jwt-nginx-plus
# author : b.wolmarans@f5.com

JWT_HEADER='{"typ":"JWT","alg":"HS256","kid":"0001"}'
JWT_PAYLOAD='{"name":"Quotation System","sub":"quotes","iss":"My API Gateway"}'
SYMMETRIC_KEY='fantasticjwt'

JWT_HEADER='{"typ":"JWT","alg":"HS256","kid":"0001"}'
echo "JWT_HEADER: $JWT_HEADER"
JWT_HEADER_B64=$(echo -n $JWT_HEADER | base64 | tr '+/' '-_' | tr -d '=')
echo "JWT_HEADER_B64: $JWT_HEADER_B64"
echo ''
JWT_PAYLOAD='{"name":"Quotation System","sub":"quotes","iss":"My API Gateway"}'
echo "JWT_PAYLOAD: $JWT_PAYLOAD"
JWT_PAYLOAD_B64=$(echo -n $JWT_PAYLOAD | base64 | tr '+/' '-_' | tr -d '=' | tr -d '\n')
echo "JWT_PAYLOAD_B64: $JWT_PAYLOAD_B64"
echo ''
JWT_HEADER_PAYLOAD_B64=$JWT_HEADER_B64.$JWT_PAYLOAD_B64
echo "JWT_HEADER_PAYLOAD_B64: $JWT_HEADER_PAYLOAD_B64"
echo ''
SYMMETRIC_KEY='fantasticjwt'
echo "SYMMETRIC_KEY: $SYMMETRIC_KEY"
JWT_SIGNATURE_B64=$(echo -n $JWT_HEADER_PAYLOAD_B64 | openssl dgst -binary -sha256 -hmac $SYMMETRIC_KEY | base64 | tr '+/' '-_' | tr -d '=')
JWT_B64=$JWT_HEADER_PAYLOAD_B64.$JWT_SIGNATURE_B64
echo ''
echo "JWT_SIGNATURE_B64: $JWT_SIGNATURE_B64"
echo ''
echo "JWT_B64: $JWT_B64"
echo -n $JWT_B64 > quotes.jwt
echo ''
SYMMETRIC_KEY_B64=$(echo -n $SYMMETRIC_KEY | base64)
echo "SYMMETRIC_KEY_B64: $SYMMETRIC_KEY_B64"
echo ''
echo "api-secret.jwk"
echo "--------------"
echo '{"keys":
    [{
        "k":"'$SYMMETRIC_KEY_B64'",
        "kty":"oct",
        "kid":"0001"
    }]
}
'
echo '{"keys":
    [{
        "k":"'$SYMMETRIC_KEY_B64'",
        "kty":"oct",
        "kid":"0001"
    }]
}                                                                                                                                                                                                                                                                                     
' > api-secret.jwk 
