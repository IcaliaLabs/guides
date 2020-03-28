# Javascript Best Practices

This is a guide to work with Javascript on IcaliaLabs projects.

## General Guidelines

When working with javascript try to follow this simple rules:

* Use camelcase for method/variable naming
* Never use global variables
* Encapsulate logic in classes, as they are easier to test. Use syntax transpiler for this, such as [babel](http://babeljs.io/).
* Use underscore at the beginning for private methods naming
* Prefer to isolate javascript code on individual files
* Prefer not to use the script tag on HTML for inline javascript code

## Package management

* Always use `yarn` instead of plain `npm`:
  * Yarn package resolution performance is better
  * Yarn selective dependency resolution is required to [deal with vulnerable sub-dependencies](#dealing-with-vulnerable-sub-dependencies)
  * Yarn workspaces feature may become commonly required

## Code Review

There are simple guidelines when providing code review to a teammate. The most particular are:

* Review for bad variable names
* Review bad class definition
* Review for class names
* Review for correct dependencies invocation
* Review for specs

## Dealing with vulnerable sub-dependencies

New security vulnerabilities on npm packages are found everyday - that's a normal thing to happen on every development platform.

Sometimes, our projects depend on an npm package that just had a vulnerability found - Github will alert us when that happens.

Depending on the team behind the vulnerable npm package, an update for that particular package will be ready in a short time.

But is quite common to have packages that could have a vulnerable packages deeply nested in their own dependencies.... and updating that dependency can become quite difficult.

Suppose we're have added the `@gridsome/transformer-remark` package to our `package.json` file. This package depends on:
- `html-to-text@^4.0.0`, which in turn depends on:
  - `optimist@^0.6.1`, which finally depends on:
    - `minimist "~0.0.1`, which [was found to be vulnerable](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7598)
    
In this case, `yarn` will keep `minimist 0.0.1` around (along with other versions of minimist), as `optimist 0.6.1` (the latest version) will still require a `0.0.x` version. This will be true **even** if you explicitly add the `minimist` version at the `package.json` file.

The best approach here would be to update `html-to-text` to version `5.1.1`, which ditches `optimist` in favor of `minimist` directly.

The problem here is that `yarn` (or npm) will still resolve `@gridsome/transformer-remark`'s dependency to `html-to-text 4.0.0`, which in turn will fetch `optimist`, and we'll end up with the vulnerable `minimist` version instead.

That's where [Yarn Selective Dependency Resolution](https://classic.yarnpkg.com/en/docs/selective-version-resolutions/) comes handy - we add the resolution rule ourselves to override `@gridsome/transformer-remark` dependency to `html-to-text` ourselves:

```json
{
  "name": "doc",
  "dependencies": {
    "@gridsome/transformer-remark": "^0.5.0"
  },
  "resolutions": {
    "@gridsome/transformer-remark/html-to-text": "^5.1.1"
  }
}
```

This will cause Yarn to resolve the `html-to-text@^4.0.0` dependency to 5.1.1 instead:

```yaml
html-to-text@^4.0.0, html-to-text@^5.1.1:
  version "5.1.1"
  resolved "https://registry.yarnpkg.com/html-to-text/-/html-to-text-5.1.1.tgz#2d89db7bf34bc7bcb7d546b1b228991a16926e87"
  integrity sha512-Bci6bD/JIfZSvG4s0gW/9mMKwBRoe/1RWLxUME/d6WUSZCdY7T60bssf/jFf7EYXRyqU4P5xdClVqiYU0/ypdA==
  dependencies:
    he "^1.2.0"
    htmlparser2 "^3.10.1"
    lodash "^4.17.11"
    minimist "^1.2.0"
```


