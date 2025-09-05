#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e

# Create a combined privkey + cert .pem file
#
# The mitmweb documentation (https://docs.mitmproxy.org/stable/concepts/certificates/#using-a-custom-server-certificate) specifies that:
#  - The `--certs` option can be used to specify your own custom cert (instead of letting mitmweb generate some on the fly)
#  - The files required are the fullchain cert + the private key, combined into a single .pem file
#
#     Using a custom server certificate
#     The certificate file is expected to be in the PEM format. You can include intermediary certificates right below your leaf certificate, so that your PEM file roughly looks like this:#     
#
#     -----BEGIN PRIVATE KEY-----
#     <private key>
#     -----END PRIVATE KEY-----
#     -----BEGIN CERTIFICATE-----
#     <cert>
#     -----END CERTIFICATE-----
#     -----BEGIN CERTIFICATE-----
#     <intermediary cert (optional)>
#     -----END CERTIFICATE-----
#
cat /opt/teevity/certs/privkey.pem \
    /opt/teevity/certs/fullchain.pem \
    > /opt/teevity/certs/combined-key-cert.pem

# Execute mitmproxy/mitmweb with all original arguments
exec "$@"
