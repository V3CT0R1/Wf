# Warfacebot-console

Warfacebot-console is shellscript to simultaneously run and control multiple instances of [Levak's warfacebot](https://github.com/Levak/warfacebot)

## How to use

### Prerequisites

* Extra PC or VPS with Debian based linux distro ( Tested on Ubuntu 16.04 ) Installed.

### Installing step by Step

 1. Clone this repository (if you didn't download it already) :
 ```
  $ git clone https://github.com/Ryuga1023/warfacebot-console.git
 ```

 2. First time setup
```
 $ cd warfacebot-console
 $ sudo ./firstrun.sh
```

 3. Run Console
```
$ ./wfbot.sh
```
### Discord bot setup
 1. Go to [Discord application registration page](https://discordapp.com/developers/applications/me). 
 2. Click on [New App](https://discordapp.com/developers/applications/me/create).
 3. Add Bot name and upload bot icon.
 4. Click on 'Create a bot user'.
 5. Click on 'Token:Click to revel' and note-down token.
 6. Open console by ./wfbot.sh , choose option 9 and enter token.
 7. Choose option 10 'Restart discord bot'.
 8. Discord bot inite link "https://discordapp.com/oauth2/authorize?client_id=BOT_CLIENT_ID&scope=bot&permissions=402705488"
 
### Console commands
 1. List installed bots - It will show current list of bots in database.
 2. Send friend request form bot - It will send the friend request from all running bots to given warface nickname.
 3. Add bot - Add bot to console database.
 4. Remove bot - Remove bot from console database.
 5. Change bot username/passowrd - Change username/password of currently available bot in database.
 6. Turn-off bots - ShutDown running bots.
 7. Restart bots - Restart the running bots.
 8. Upadte (Use after game update only) - To update gameversion file, Run once after new game update.
 9. Set discord bot secret - Enter bot secret file which you got from [Discord Apps](https://discordapp.com/developers/applications/).
 10. Restart discord bot - It will restart discord bot.
 11. Turn-off discord bot - It will turn-off discord bot.
