# Working with Git

- See [git](https://git-scm.com/) for details, documentation and downloads.
- [Scott Hanselman](https://www.hanselman.com/blog/) has some great explainer videos for git on his YouTube channel playlist [Things they didn't teach you at school](https://www.youtube.com/watch?v=TtiBhktB4Qg&list=PL0M0zPgJ3HSesuPIObeUVQNbKqlw5U2Vr)

## Contents

1. [Branch merging](#merging-branches)
1. 

## Merging Branches

- A parent branch such as master or main has been branched to develop a fix or feature
- Since the branch was made changes have been committed back onto the parent branch
    - e.g. another member of the team merged changes to add a different fix or feature
- There are now changes to files on the parent branch which now block the feature branch from being successfully merged back in via a pull request

### Solution

- Prior to creating a pull request changes from the parent can be merged into the feature branch as follows

```bash
git checkout <parent_branch> # could be master/main etc.

git pull # ensure that the local parent is fully up to date

git checkout <feature_branch> # switch back to working branch

git merge <parent_branch>

Auto-merging <file(s)>
CONFLICT (content): Merge conflict in <file(s)>
Automatic merge failed; fix conflicts and then commit the result. # automatic merge has failed

git mergetool # this will open the merge tool/editor configured in ~/.gitconfig

# use the editor to resolve conflicts and/or correct issues as required
# save changes and close editor

git commit # add and commit files as usual
```
