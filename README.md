# FlareBlog

This is a git repository for the FlareBlog. The Blog is based on [Hugo](https://gohugo.io/) and [FixIt](https://github.com/hugo-fixit/FixIt) theme.

The theme is pinned to **FixIt v1.0.0-alpha.3** and **component-projects v2.2.0**.
Building requires **Hugo Extended >= 0.161.0** and **Dart Sass >= 1.99.0**.
FixIt v1 is a prerelease; review theme upgrades before changing the submodule commits.

## Run in local

Clone the repository:

```bash
git clone --recurse-submodules https://github.com/JamesFlare1212/FlareBlog.git
```

For an existing checkout, initialize the pinned submodule versions:

```bash
git submodule update --init --recursive
```

Then, install Hugo Extended and Dart Sass. Sass must be available on `PATH`.

For Linux:
```bash
wget https://github.com/gohugoio/hugo/releases/download/v0.161.0/hugo_extended_0.161.0_linux-amd64.deb
sudo dpkg -i hugo_extended_0.161.0_linux-amd64.deb

# Install Dart Sass for the current user (Linux x86_64).
curl -fL -o /tmp/dart-sass.tar.gz https://github.com/sass/dart-sass/releases/download/1.99.0/dart-sass-1.99.0-linux-x64.tar.gz
mkdir -p "$HOME/.local/lib"
tar -xzf /tmp/dart-sass.tar.gz -C "$HOME/.local/lib"
export PATH="$HOME/.local/lib/dart-sass:$PATH"
```

Add the `PATH` export to your shell configuration to keep Sass available in new terminals.

For MacOS:
```bash
brew install hugo
brew install sass/sass/sass
```

Verify the toolchain:

```bash
hugo version
sass --version
```

Serve the blog locally:

```bash
cd FlareBlog
hugo server
```

Open the browser and go to `http://localhost:1313/` to see the blog.

Build the production site with `hugo --minify`. Deployment environments also need
Hugo and Dart Sass installed. Search continues to use Fuse; no Pagefind indexing
step is required.

Custom styles live in `assets/scss/custom.scss`. Theme settings use snake_case
under `[params]`, including page defaults; see the
[FixIt v1 migration guide](https://fixit.lruihao.cn/guides/upgrade-to-v1/).

## Create new posts

```bash
hugo new content/zh-cn/posts/stellaris/dlc-unlocker/index.md
```
