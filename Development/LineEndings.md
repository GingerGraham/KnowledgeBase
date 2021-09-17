# Line Endings

## Index

- [Linux Line Endings Error](#linux-line-endings-error)

## Linux Line Endings Error

- Error message: `/usr/bin/env: ‘python\r’`

        gwatts@gw-x260$ ./FirstMaths.py
        /usr/bin/env: ‘python\r’: No such file or directory

- Cause: Windows **CRLF** endings being used
- Resolution: `dos2unix`
    - Run `dos2unix` to convert line endings to Unix **LF** endings

            gwatts@gw-x260$ dos2unix HelloWorld.py
            dos2unix: converting file HelloWorld.py to Unix format...

- Reference: [Scott Hanselman: Carriage Returns and Line Endings](https://www.hanselman.com/blog/carriage-returns-and-line-feeds-will-ultimately-bite-you-some-git-tips)
