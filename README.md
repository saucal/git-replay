# GIT Replay Command

This will allow you to bulk cherry pick commits between 2 points. Useful to replay whole branches when cherry picking features.

### Usage

```
sh -c "$(curl https://raw.githubusercontent.com/saucal/git-replay/master/git-replay.sh -s)" -- "{BEGIN}" "{END}" "{PLACEMENT}"
```

Where 

* **{BEGIN}** -> Is the commit from which you want to start replaying (commit before the first one to be cherry picked)
* **{END}** -> Last commit to be cherry picked
* **{PLACEMENT}** -> The branch where your commits will end up on top of (for partial deployments, this is typically master/main)
