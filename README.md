# Haskell Programming in the Small

Software has a tendency to start as a casual afternoon experiment
and then metastasize into a massive enterprise.

I mention this tendency when I am participating in a conversation about
the merits of programming languages and am advised
to “pick the right tool for the job.”

The scope of the job is so often
unknown when beginning it. That tool-picking advice is especially troublesome in
the important case when one is surprised by the increasing importance of the
job and the rapid metastatic success of the program which performs the job.

In the happy circumstance that people actually use our software,
we want to be able to scale it up in performance and complexity. If the
tool picked was Python or PHP, then scaling it up will require
[heroic feats of computer programming](https://www.facebook.com/note.php?note_id=10150415177928920).

Haskell distinguishes itself in how well it applies to a broad domain
of computer programming tasks from [grand to trivial](https://en.wikipedia.org/wiki/Programming_in_the_large_and_programming_in_the_small).

It is famously well-suited for large programs which must
[run fast](http://benchmarksgame.alioth.debian.org/u64q/which-programs-are-fastest.html),
[refactor easily](http://neilmitchell.blogspot.jp/2015/02/refactoring-with-equational-reasoning.html),
and
[be maintained](https://www.fpcomplete.com/blog/2016/12/software-project-maintenance-is-where-haskell-shines).

If we use Haskell for the little jobs, then
we are prepared when a little job expands into a major career project.

This is a cookbook about Haskell programming in the small. Haskell is
wonderful for the daily command-line work of scripting, analysis, and automation.
There is no trade-off! Once one has the recipies at hand, Haskell one-liners
are as easy as Perl and Haskell scripts are as easy as Python.

1. Haskell one-liners for Unix pipes.
2. Haskell executable script files.
3. Haskell one-off buildable projects.

For these recipies, the essential ingredients are the
[Glasgow Haskell Compiler](https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/index.html)
and the
[Haskell Stack](https://docs.haskellstack.org/en/stable/README/).

### Recipies for `stack ghc -e` One-Liners

Using Haskell to participate in Unix pipes.

[Haskell on the Command Line by Joachim Breitner](http://www.joachim-breitner.de/blog/156-Haskell_on_the_Command_Line)

Maybe a special package for command-line usage?

#### `.ghci`


There is a [Perl tradition of one-liners](http://www.catonmat.net/blog/introduction-to-perl-one-liners/), which allow us to use Perl at the
command line to participate in Unix pipe expressions. The feature of Perl
which makes it so suitable for one-liners is
the [implicit `$_` variable](https://perlmaven.com/the-default-variable-of-perl)

Haskell also has a feature which makes it very suitable for one-liners, and that
is [point-free expressions](https://wiki.haskell.org/Pointfree).


The `-e` argument to `ghc` has the same meaning that it does for `perl`; it
puts `ghc` in [GHC Expression evaluation mode](https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/using.html#eval-mode).

[Haskell One Liners by Paul Meng](http://mno2.github.io/posts/2015-02-26-haskell-one-liners.html)

[H by Mitchell Rosen](https://github.com/mitchellwrosen/h)

```bash
$ echo "hello" | stack --package split ghc -- -e "interact sort"

# apply function (String -> String) to entire stream
# example: name the argument
# echo "hello" | ghce '\x -> sort x'
# echo "hello" | ghce sort
ghce () {
    stack ghc --package split --package safe --verbosity error -- -e "interact ( $* )"
}

# apply function ([String] -> [String]) to all lines
#
# from column 4 of passwd, show entries which contain an uppercase and don't contain a comma and consist of exactly two words
# cat /etc/passwd | ghcel 'filter ((==2).length.words) . '"filter (not.any (==','))"'. filter (any isUpper) . fmap ((!!4) . splitOn ":")'
#
# grep from stdin lines for which column 4 is numerically greater than 100
# ghcel "filter (\l -> (words l ^? ix 4) >>= readMay & maybe False (>100))"
ghcel () {
    stack ghc --package split --package safe --verbosity error -- -e "interact $ unlines . ( $* ) . lines"
}

# fmap function (String -> String) to each line
# example: split on commas and select the 0th and 3rd columns
# echo "a,b,c,d,e,f" | ghcelf 'unwords . flip fmap [0,3] . (!!)  . splitOn ","'
ghcelf () {
    stack ghc --package split --package safe --verbosity error -- -e "interact $ unlines . fmap ( $* ) . lines"
}
```




### Recipies for `stack script` Scripts

Creating self-contained single-file bitrot-free executable scripts.

[How to Script with Stack](https://haskell-lang.org/tutorial/stack-script)

Use Text not String.

[stack script interpreter](https://docs.haskellstack.org/en/stable/GUIDE/#script-interpreter)




### Recipies for `stack new` One-Off Projects

Creating one-off projects.
