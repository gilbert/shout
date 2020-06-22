# New App

Features:

- [User accounts](https://github.com/thoughtbot/clearance)
- [Tailwind.css](https://tailwindcss.com)
- [Alpine.js](https://github.com/alpinejs/alpine)
- [Heroicons](https://github.com/refactoringui/heroicons)

## Getting started

```bash
$ bundle
$ yarn
$ rails db:create db:migrate db:seed
$ rails s

# Get rid of those pesky warnings
$ export RUBYOPT='-W:no-deprecated -W:no-experimental'
```

## Debug Helpers

Visit [/debug](http://localhost:300/debug) to view handy debug features.

## Icons

Imported [Heroicons](https://github.com/refactoringui/heroicons) are available to render in views on demand. Here's an example:

```erb
<%= render 'icons/outline/camera', class: 'h-6 w-6 text-gray-500' %>
```
