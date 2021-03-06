#1 Introduction
bash\_down is an extension of markdown that allows you to run arbitrary shell commands (in any shell you want) and generate tests inline with your software spec. It automatically outputs a markdown version without the extra bash\_down stuff, and it is extensible with your own parsers and runners for tests.

#2 Markdown
Since the parser just writes whatever is not specifically bash\_down to a file, you can use whatever flavor of markdown you wish.

##2.1 Section Numbers
The one convenience added to markdown for you is section numbers. Use Headings to indicate sections and nesting. The number of "#"s indicate the level of nesting.
i.e.:
```
~#heading
~some text
~
~##nested heading
```
will produce:
```
~#1 heading
~some text
~
~##1.1 nested heading
```

#3 Scripts
To add arbitrary scripts and commands simply make a line that contains only "#!". The following lines will be saved to a script and then run after you close your inline script with a line containing just "!#".
i.e.:
```
~#!
~echo something
~!#
```

##3.1 Shells
You can use other shells (like python, node, ruby, etc...). Just replace the #! line with #!/bin/python like you would writing a script file. The naked #! defaults to bash.
i.e.:
```
~#!/bin/python
~print 'something pythony with no semi-colons"
~!#
```

##3.2 Commenting scripts
Scripts can be commented by adding a "#" before the "#!". i.e.: "##!"

#4 Tests
Inline test annotations are meant to be one-liners and are created by using the #! with the name of an existing parser (in src/parsers/).
i.e.:
```
~#!browser "$('.some-class').length === 3"
```

##4.1 Test Files
Sometimes a test won't fit on one line or fit the norm of the parser. You can place custom tests (that must conform to your runner) and call them by name. i.e.:
```
~#!bash_down arbitrary
```

##4.2 Parsers
Parsers are passed the heading they fall under, that heading as a filename-safe string, and whatever arguments you pass to the parser. The output is appended to a file by the same name as the parser in the output's test folder.

##4.3 Runners
Runners take the test file created incrementally by the parser and use the data to run tests in one fashion or another.

##4.4 Folder Structure
When bash\_down runs it creates a folder named bash\_down\_and\_out with child folders for scripts and tests. The parsers and runners are in the src folder of the bash\_down repository. Every parser must have a runner by the same name and vice versa.

###4.4.1 Scripts
The scripts in the scripts folder are the inline scripts you created.

###4.4.2 Tests
The tests in the tests folder are the output of the parsers.

