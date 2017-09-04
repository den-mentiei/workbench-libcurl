# libcurl

Pre-built libcurl with only HTTP/HTTPS (& gzip) enabled.

For scripts and updates go [here](https://github.com/den-mentiei/workbench-libcurl).

## SSL

The library is compiled with only 1 default SSL-backend:
* _TODO_ Windows - native WinSSL (SChannel).
* _TODO_ macOS/iOS - native Secure Transport.
* Linux - built-in [mbedtls](https://github.com/ARMmbed/mbedtls).
* _TODO_ Android - built-in [mbedtls](https://github.com/ARMmbed/mbedtls).

## Used commits
