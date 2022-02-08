# NyulibrariesTemplates 

[![NYU](https://github.com/NYULibraries/nyulibraries_stylesheets/blob/master/app/assets/images/nyulibraries_stylesheets/nyu.png)](https://dev.library.nyu.edu)
[![Build Status](https://travis-ci.org/NYULibraries/nyulibraries_templates.svg)](https://travis-ci.org/NYULibraries/nyulibraries_templates)
[![Code Climate](https://codeclimate.com/github/NYULibraries/nyulibraries_templates/badges/gpa.svg)](https://codeclimate.com/github/NYULibraries/nyulibraries_templates)
[![Coverage Status](https://coveralls.io/repos/github/NYULibraries/nyulibraries_templates/badge.svg?branch=master)](https://coveralls.io/github/NYULibraries/nyulibraries_templates?branch=master)

## Installation

```
gem 'nyulibraries_templates', git: "https://github.com/NYULibraries/nyulibraries_templates"
```

### Optional dependencies

#### NyulibrariesInstitutions

Various helpers and views make use of methods from [`NyulibrariesInstitutions`](https://github.com/NYULibraries/nyulibraries_institutions). To take advantage of these helpers, the client application must include the gem:

```
gem 'nyulibraries_institutions', git: "https://github.com/NYULibraries/nyulibraries_institutions"
```

Without this gem, headers and other institution-dependent views will default to NYU.

#### Defining `current_user`, `login_url`, `logout_url`

`NyulibrariesTemplates` uses a `current_user` method if its defined in the client app. It looks for the methods `firstname` and `lastname` and – if the first is not defined – `username`.

Various layouts will also include `login_url` or `logout_url` as necessary if they are defined.

Installing [devise](https://github.com/plataformatec/devise) with a User model that defines `firstname` and `lastname` will satisfy all these requirements.

## Usage

Specify any of the predefined layouts in your Rails `ApplicationController`:

```
layout "bobcat"
```

Most of the remaining views are rendered as part of the layout, but you can render them explicitly as with any other view:

```
<%= render "common/alerts" %>
```

Most of the helper methods are defined for use in the layouts, but you can also use them explicitly:

```
<%= link_to_with_popover "Click me", "http://example.com", "Some extra info in a popover"
```

You can also override certain helper methods to modify the layouts. Commonly modified methods include:

| Method name | Return expected |
|---|---|
| `application_title` | string name of application |
| `breadcrumbs` | collection of HTML links for use in layout breadcrumbs |
| `meta` | collection of HTML meta tags for use in layout head tag |
| `prepend_body` | HTML to be prepended to the body |
| `show_tabs` | boolean: whether to render tabs in layout |
| `tabs` | collection of hashes, each with keys `"code"`, `"url"`, and `"link"` |


## Upgrading from Nyulibraries::Assets

Since mustache was removed in favor of ERB, all mustache view files must be converted to helper files.

The following helper methods were removed:

- `page_entries_info_sunspot`
