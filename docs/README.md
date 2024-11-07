# Tartarus documentation & presentations

## Build

The slides are expected to be processed by [pandoc][] to produce [reveal.js][reveal-js] presentations.

```
pandoc -s -i --highlight-style zenburn --slide-level 2 -t revealjs -o tartarus-meeting-1.html tartarus-meeting-1.md
```

[pandoc]: https://pandoc.org
[reveal-js]: https://revealjs.com
