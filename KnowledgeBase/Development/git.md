# Working with Git

Git is the most popular version control system in the world. It is used to manage code, track changes, and collaborate with others.  Understanding how to work with git is essential to collaborating with teams and projects around the world.

- See [git](https://git-scm.com/) for details, documentation and downloads.
- [Scott Hanselman](https://www.hanselman.com/blog/) has some great explainer videos for git on his YouTube channel playlist [Things they didn't teach you at school](https://www.youtube.com/playlist?list=PL0M0zPgJ3HSesuPIObeUVQNbKqlw5U2Vr)

## Git 101

I won't try and cover it here, I'll let Scott do the talking.

{% include youtube.html id="WBg9mlpzEYU" %}

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

### Notes

- **Caution:** when working with encrypred files such as `ansible-vault` files it is important to ensure that the file is decrypted before merging and then re-encrypted after the merge is complete
- A good, visual, editor such as [VS Code](https://code.visualstudio.com/) is recommended for resolving merge conflicts as it can help to identify the changes and make it easier to resolve the conflicts

## Multiple Branches

Sometimes it may be necessary to work with more than one branch of a repo at the same time; for example when preparing a release branch while also working on current development features, or switching to fix a bug in one branch while continuing to work on another.

While options such as stashing and switching branches are available, it is often easier to work with multiple branches using `git worktree`.

### Git Worktrees

`git worktree` allows you to checkout existing branches, or a new branch linked to the same repo

Below is an example adding a new worktree for the `release/1.4.0` branch of a given repository. Notice in the prompt where when the directory is `~/Development/tooling-devops` the branch shows `master` however when the directory is `~/Development/release-1-4` the branch shows as `release/1.4.0`

```bash
(~/Development/tooling-devops)
(10:35:37 on master)> git worktree add ../release-1-4 release/1.4.0
Preparing worktree (checking out 'release/1.4.0')
Updating files: 100% (696/696), done.
HEAD is now at 78cf56d Nodemonitoring Service Scaled to 5 pods

(~/Development/tooling-devops)
(10:44:47 on master)> cd ../release-1-4 

(~/Development/release-1-4)
(10:45:00 on release/1.4.0)> git worktree list
/Users/grwatts/Development/toolingdevops 1ca9082 [master]
/Users/grwatts/Development/release-1-4 78cf56d [release/1.4.0]
```

## Links

- <https://git-scm.com/docs/git-worktree>
- <https://opensource.com/article/21/4/git-worktree#:~:text=The%20answer%20is%20Git%20worktree.%20What%20is%20Git%3F,a%20different%20state%20and%20on%20a%20different%20branch.>

