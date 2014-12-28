#vim-bashcomp
To complete variables formally in shell. 

## Introduction
If you have the following bash script,

```sh
if [ -n hoge ];
```

you can just push { or } anywhere over hoge and you'll get this.

```sh
if [ -n ${hoge} ];
```

Additionally, you can push " anywhere over ${hoge} and you'll get this.

```sh
if [ -n "${hoge}" ];
```

Sometimes, there is . at the end and variable right before it.
```sh
This is a hoge.
```

It works like this by excluding . right after hoge.
```sh
This is a ${hoge}.
```

You can also do it for the first word.
```sh
${This} is a ${hoge}.
```

