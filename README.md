# Fengwei Xu - academic homepage

This repository contains the source for [xfengwei.github.io](https://xfengwei.github.io), built with the [Academic Pages](https://github.com/academicpages/academicpages.github.io) Jekyll template.

## Repository structure

- `_config.yml` contains site-wide identity, contact, and metadata settings.
- `_pages/` contains the homepage, research overview, CV, and listing pages.
- `_publications/`, `_talks/`, and `_teaching/` contain structured academic records.
- `images/research/` contains figures used in the research overview.
- `files/Personal_Resume_Fengwei_Xu.pdf` is the downloadable CV.

## Local preview

Install Ruby, Bundler, and the repository dependencies, then run:

```bash
bundle config set --local path vendor/bundle
bundle install
bundle exec jekyll serve --livereload
```

The local site is available at `http://localhost:4000`.

## Updating the template

The `origin` remote points to the public homepage repository. The `upstream` remote points to Academic Pages. Keep personal content changes in focused commits so future upstream updates can be reviewed and merged selectively.
