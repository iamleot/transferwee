transferwee can be considered more or less feature complete.
There are at least some known (and probably several unknown!) bugs
and possible TODOs:

## TODO/Known bugs

- Gracefully handle possible file overwrites in download, no checks are done and
  files are always overwritten.
- Write a `setup.py`
- Add SIGINFO/SIGUSR1 handlers to print the status of the upload/download
- Add an `ads` or similar subcommand in order to show one or more ads that are
  showed during file uploads

## Possible TODOs

- Add a `-d dir` option to specify a base directory for upload/download?
- Convert `tests/check.sh` in pure Python code?
