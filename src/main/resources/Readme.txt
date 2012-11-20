This is still under development. For help, ask arjankranenburg (at) users.sf.net

Testium.jar is the actual deliverable of this project. Since Documentation is not yet in place, I advice you to use the TestiumDemo.zip as starting point for your project.

TestiumDemo.zip is an example project to demonstrate some of the possibilities of Testium. It includes some other plugins, like the SeleniumPlugin as well.

PREREQUISITES:
- Java 1.6 or later
- One of InternetExplorer, FireFox, Chrome (By default the demo uses FireFox)

INSTALLATION:
- Unzip TestiumDemo.zip to the location of your choice

CONFIGURATION:
- To be described.
- Every parameter that is in the config dir can be overriden in a personal settings files.
- By default, personal settings files are stored in the <user-dir>/.testium/ directory.
- Personal settings files have the same name as the global settings files, except for global.xml which for users is called general.xml.

USAGE:
- Double click the Testium.bat to run all TCs in the Demo (fo course only on Windows)
- On a command-line: Testium.bat <command>
- Default command is 'execute'. Other commands are 'interfaces', 'keywords', 'validate'

USAGE (2):
- The jar file can also be executed (from TestiumDemo directory):
java -jar src/Testium.jar --command execute --globalconfigfile config/global.xml --file test/all.xml
- 'help' will show you more possibilities:
java -jar src/Testium.jar --help


SOME OTHER NOTES:
- The perl-prepare script currently errors and 2 other TCs are designed to error!
- You can later move the directory since no Registry is used and no full paths are used in configuration.
- The results are best viewed in FireFox

NEXT FEATURES:
- Ability to combine commands to new commands.

LICENSE:
- GNU General Public License (GPL)

SUPPORT, HELP, or REQUESTS:
- Contact arjankranenburg (at) users.sf.net

DISCLAIMER:
- Use at own risk
- This software comes with no warranties whatsoever.
- The author(s) are never responsible for harm or damage done to your sfotware or organization. 
