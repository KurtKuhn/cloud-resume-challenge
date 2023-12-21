---
title: "Using Hugo for the First Time (and My First Post!)"
date: 2023-09-11T15:10:26-06:00
draft: true
---

## Foreword

This is my first post on my very first blog.  The goal of this blog is to document
my journey of doing the [Cloud Resume Challenge](https://cloudresumechallenge.dev/)
The challenge itself is using AWS services for the backend and content distrubition.  
As well, I'll be attempting infrastructure as code, mainly through Terraform. The CI/CD
process with GitHub Actions.

I'm somewhat comfortable with the more well known AWS service, such as Lambda and DynamoDB.
I'm trying to really understand Terraform and the CI/CD process and how it falls to grand scheme.

This project requires code for the frontend and that will be done with Hugo.  
The logic for hugo is I'm not looking to hone my frontend skills, so I would like to experiment with a new framework

## What Is Hugo?

[Hugo](https://gohugo.io/) is an open source static site generator.  It uses Go to produce HTML files from markdown files

### Installing Hugo

If you have Homebrew installed on macOS, it is quite easy. Simply run the command from your terminal:

```powershell
  brew install hugo
```
If you're not using the macOS, you can find many more installation options [here](https://gohugo.io/installation/)

Hugo allows the use for additional themes. I was looking for a lightweight theme and decided on [Blowfish](https://blowfish.page/)

The installation of the theme has a bit more steps.


```powershell
hugo new site <your_website_name>
cd <your_website_name>
git init
git submodule add -b main https://github.com/nunocoracao/blowfish.git themes/blowfish
```

Stepping through the code:

This creates a new hugo project which will be your basis

```powershell
hugo new site <your_website_name>
```

We change the working directory to the folder that the above command created

```powershell
cd <your_website_name>
```

Simply initalizes the working directory as a git repo and adds the Blowfish submodule

```powershell
git init
git submodule add -b main https://github.com/nunocoracao/blowfish.git themes/blowfish```
```

### Other Stuff
