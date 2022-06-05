![Check and test transferwee](https://github.com/iamleot/transferwee/workflows/Check%20and%20test%20transferwee/badge.svg)
[![Total alerts](https://img.shields.io/lgtm/alerts/g/iamleot/transferwee.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/iamleot/transferwee/alerts/)

# transferwee

transferwee is a simple Python 3 script to download/upload files via
[wetransfer.com](https://wetransfer.com/).


## Usage

```
% transferwee -h
usage: transferwee [-h] {download,upload} ...

Download/upload files via wetransfer.com

positional arguments:
  {download,upload}  action
    download         download files
    upload           upload files

optional arguments:
  -h, --help         show this help message and exit
```

### Upload files

`upload` subcommand uploads all the files and then print the shorten
URL corresponding the transfer.

If both `-f` option and `-t` option are passed the email upload
will be used (in that way the sender will get an email after the
upload and after every recipient will download the file, please
also note that because `-t` option accepts several fields a `--`
is needed to separate it with the file arguments).
Otherwise the link upload will be used.

```
% transferwee upload -h
usage: transferwee upload [-h] [-n display_name] [-m message] [-f from] [-t to [to ...]] [-v] file [file ...]

positional arguments:
  file             files to upload

optional arguments:
  -h, --help       show this help message and exit
  -n display_name  title for the transfer
  -m message       message description for the transfer
  -f from          sender email
  -t to [to ...]   recipient emails
  -v               get verbose/debug logging
```

The following example creates an `hello` text file with just `Hello world!` and
then upload it with the message passed via `-m` option:

```
% echo 'Hello world!' > hello
% md5 hello
MD5 (hello) = 59ca0efa9f5633cb0371bbc0355478d8
% transferwee upload -m 'Just a text file with the mandatory message...' hello
https://we.tl/o8mGUXnxyZ
```

### Download file

`download` subcommand download all the files from the given
we.tl/wetransfer.com URLs.

If the `-g` option is used it will just print the direct link
corresponding each URLs without downloading files.

The URL supported are the ones in the form:

 - `https://we.tl/<short_url_id>`: 
    received via link upload, via email to the sender and printed by
    `upload` action
 - `https://wetransfer.com/<transfer_id>/<security_hash>`:
    directly not shared in any ways but the short URLs actually redirect to
    them
 - `https://wetransfer.com/<transfer_id>/<recipient_id>/<security_hash>`: 
    received via email by recipients when the files are shared via email
    upload

```
% transferwee download -h
usage: transferwee download [-h] [-g] [-o file] [-v] url [url ...]

positional arguments:
  url         URL (we.tl/... or wetransfer.com/downloads/...)

optional arguments:
  -h, --help  show this help message and exit
  -g          only print the direct link (without downloading it)
  -o file     output file to be used
  -v          get verbose/debug logging
```

The following example download the `hello` text file that was uploaded in the
previous example for `upload` subcommand. Please note that if any file with the
same name already exists it will be overwritten!:

```
% transferwee download https://we.tl/o8mGUXnxyZ
% cat hello
Hello world!
% md5 hello
MD5 (hello) = 59ca0efa9f5633cb0371bbc0355478d8
```

## Dependencies

transferwee needs [requests](http://python-requests.org/) package.
