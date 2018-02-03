# Contribution

* Commit changes to a branch locally. Push the branch to GitHub.
* Submit a pull request for review. The process also triggers automated Docker Hub image build for the branch.
* **_Verify_** that automated Docker Hub image [build](https://hub.docker.com/r/praqma/jekyll/builds/) for that the branch is successful.
* Merge the pull request into master branch.
* Update tagging information by following steps.

## Tag

Assuming that we want to release an image named `praqma/jekyll:0.4`.

* Tag the latest commit on master branch.

```
git tag -s 0.4 -m "Scan CSS for unused resources."
```

* Push tags to remote origin.

```
git push --follow-tags
```

**_Verify_** that the new tag available on GitHub [tags](https://github.com/Praqma/jekyll/tags) page.

New tag on the latest commit on master branch will trigger automatic [build](https://hub.docker.com/r/praqma/jekyll/builds/) in Docker Hub.

**_Verify_** that the new tag [builds](https://hub.docker.com/r/praqma/jekyll/builds/) successfully on Docker Hub.

## Release

* Open GitHub Releases [page](https://github.com/Praqma/jekyll/releases).
* Click on `Draft a new release` button.
* Choose an existing tag. The new tag already existed on GitHub.
* Enter release title with this format: `jekyll:0.4`. Replace `0.4` inside the string with the new tag.
* Enter the description with issues resolved since last release.
* Click `Publish release` button.

## Verify

**_Verify_** that the new tag exist in the following places.

* [GitHub](https://github.com/Praqma/jekyll/tags)
* [Docker Hub](https://hub.docker.com/r/praqma/jekyll/builds/)
* [GitHub Releases](https://github.com/Praqma/jekyll/releases)
