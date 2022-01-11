---
---
# gitconfig files

- This page discusses some of the customisations and configurations for .gitconfig files
- See [Git Configuration](https://www.git-scm.com/book/en/v2/Customizing-Git-Git-Configuration) for more details

## Contents

- [Auto CRLF](#auto-crlf)

## Auto CRLF

- Carriage Return (CR)
- Line Feed (LF)

When working between Windows (CRLF), Linux/Unix (LF) and some versions of Mac OS (CR) line endings can be an issue and cause scripts and programs not to run as expected where the OS doesn't correctly parse the code.

Scott Hanselman has a good primer video here: [What's a Carriage and Who's Feeding it Lines? CRLF - Computer Stuff They Didn't Teach You #1](https://www.youtube.com/watch?v=TtiBhktB4Qg&list=PL0M0zPgJ3HSesuPIObeUVQNbKqlw5U2Vr&index=1)

- When installing [Git For Windows](https://gitforwindows.org/) it prompts for an option of "Checkout Windows style, commit Unix style" which automatically sets this property
- Alernatively this can be configured directly in the .gitconfig file or from the command line

```bash
       │ File: /Users/grwatts/.gitconfig
───────┼───────────────────────────────────────────────────────────────────────────────────────
   1   │ [core]
   2   │     autocrlf = true
```

```bash
git config --global core.autocrlf=true
```
