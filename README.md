# jekyll

Jekyll's Docker image for building Praqma's website.

See [jekyll](https://github.com/praqma/jekyll) GitHub repository.

See [jekyll](https://hub.docker.com/r/praqma/jekyll/) image on Docker Hub.

## Update Dockerfile

Please tag your commit to release a new tagged Docker image.

Use the below command to push new commits along with its tags simultaneously.

`git push --follow-tags`

The man pages explains, as shown below.

```
--follow-tags

Push all the refs that would be pushed without this option, and also push
annotated tags in refs/tags that are missing from the remote but are pointing
at commit-ish that are reachable from the refs being pushed. This can also be
specified with configuration variable push.followTags. For more information,
see push.followTags in git-config(1).
```
