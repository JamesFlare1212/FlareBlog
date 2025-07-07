# FlareBlog

This is a git repository for the FlareBlog. The Blog is based on [Hugo](https://gohugo.io/) and [FixIt](https://github.com/hugo-fixit/FixIt) theme.

## Run in local

Clone the repository:

```bash
git clone --recurse-submodules https://github.com/JamesFlare1212/FlareBlog.git
```

Then, install Hugo.

For Linux:
```bash
wget https://github.com/gohugoio/hugo/releases/download/v0.147.7/hugo_extended_0.147.7_linux-amd64.deb
sudo dpkg -i hugo_extended_0.147.7_linux-amd64.deb
```

For MacOS:
```bash
brew install hugo
```

Server the blog locally:

```bash
cd FlareBlog
hugo server
```

Open the browser and go to `http://localhost:1313/` to see the blog.