# Understanding And Working With Line Endings

If your workflow ever calls for working with multiple different platforms such as Windows, Linux and Mac, then you will need to be able to work with line endings.  This is a common problem when working with text files.

## Linux Line Endings Error

- Error message from Python: `/usr/bin/env: 'python\r': No such file or directory`

        gwatts@gw-x260$ ./HelloWorld.py
        /usr/bin/env: 'python\r': No such file or directory

- Error message from bash: `/bin/sh^M: bad interpreter: No such file or directory`

        gwatts@gw-x260$ ./HelloWorld.sh 
        -bash: ./clusterCheck.sh: /bin/sh^M: bad interpreter: No such file or directory
        
- Cause: Windows **CRLF** endings being used
- Resolution: `dos2unix`
    - Run `dos2unix` to convert line endings to Unix **LF** endings

            gwatts@gw-x260$ dos2unix HelloWorld.py
            dos2unix: converting file HelloWorld.py to Unix format...

- Reference: [Scott Hanselman: Carriage Returns and Line Endings](https://www.hanselman.com/blog/carriage-returns-and-line-feeds-will-ultimately-bite-you-some-git-tips)
