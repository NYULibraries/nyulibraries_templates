# NyulibrariesTemplates

[![NYU](https://github.com/NYULibraries/nyulibraries_stylesheets/blob/master/app/assets/images/nyulibraries_stylesheets/nyu.png)](https://dev.library.nyu.edu)
[![Build Status](https://travis-ci.org/NYULibraries/nyulibraries_templates.svg)](https://travis-ci.org/NYULibraries/nnyulibraries_templates)
[![Code Climate](https://codeclimate.com/github/NYULibraries/nyulibraries_templates/badges/gpa.svg)](https://codeclimate.com/github/NYULibraries/nyulibraries_templates)
[![Coverage Status](https://coveralls.io/repos/github/NYULibraries/nnyulibraries_templates/badge.svg?branch=master)](https://coveralls.io/github/NYULibraries/nnyulibraries_templates?branch=master)

## Usage

```
gem 'nyulibraries_templates', git: "https://github.com/NYULibraries/nyulibraries_templates"
```

## Optional dependencies

### NyulibrariesInstitutions

Various helpers and views make use of methods from `NyulibrariesInstitutions`. To take advantage of these helpers, the client application must include the gem with the correct version:

```
gem 'nyulibraries_institutions', '>= 1'
```

Without this gem, headers and other institution-dependent views will default to NYU.

### current_user, login_url, logout_url

The client application may define `current_user`. If it does, `NyulibrariesTemplates` looks for methods `firstname` and `lastname` and – if the first is not defined – `username` on the object returned by `current_user`. Without `current_user` or any of these methods on the object it returns, these methods return `nil`.

The client application may also define certain login URL helpers: `login_url` and `logout_url`. If it does, these links will be included in the header of certain views, depending on whether `current_user` is present. Without these methods, headers won't include login/logout links.

## Upgrading from Nyulibraries::Assets

Since mustache was removed in favor of ERB, all mustache view files must be converted to helper files.

The following helper methods were removed:

- `page_entries_info_sunspot`
