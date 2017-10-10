# libcurl

Pre-built libcurl with only HTTP/HTTPS (& gzip) enabled.

For scripts and updates go [here](https://github.com/den-mentiei/workbench-libcurl).

## SSL

The library is compiled with only 1 default SSL-backend:
* Linux - built-in [mbedtls](https://github.com/ARMmbed/mbedtls).
* macOS - native Secure Transport.
* _TODO_ Windows - native WinSSL (SChannel).
* _TODO_ iOS - native Secure Transport.
* _TODO_ Android - built-in [mbedtls](https://github.com/ARMmbed/mbedtls).

## Used commits
