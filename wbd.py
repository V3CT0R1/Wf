import discord
import subprocess
import asyncio
import os
import time
import re
from discord.ext import commands
bot = commands.Bot(command_prefix='wf!', description='Warface Bot By Darsh!!')
bot.remove_command("help")
@bot.event
@asyncio.coroutine 
def on_ready():
  print('Logged in as')
  print(bot.user.name)
  print(bot.user.id)
  print('Bot Invite Link => https://discordapp.com/oauth2/authorize?&client_id='+bot.user.id+'&scope=bot&permissions=0' )
@bot.command()
@asyncio.coroutine 
def add(message):
    yield from bot.say("Sending Request to " +  message)
    cmd = './wfbot.sh add {0}'.format(message)
    subprocess.call(cmd.split(),shell=False)

@bot.command()
@asyncio.coroutine 
def restart():
   os.system('./wb_restart')
   yield from bot.say("Restarting bots!")
   
@bot.command()
@asyncio.coroutine 
def who(nick):
    comm = './wfbot.sh whois {0}'.format(nick)
    subprocess.call(comm.split(),shell=False)
    time.sleep(2)
    f = open('whois','r')
    data = f.read()
    f.close()
    yield from bot.say('```' + data + '```') 
    os.remove('whois')
    
@bot.command()
@asyncio.coroutine 
def help():
    yield from bot.say('```             WARFACEBOT TOOL \n \n  help       : show this message \n  stats      : list currently online players \n  who [nick] : shows player ip,country,rank \n  restart    : restart bots  \n  add [nick] : send friend request to player \n \n  Created By Envy \n  darshanhihoriya@gmail.com/Envy#4508  ```') 

@bot.command()
@asyncio.coroutine 
def stats():
    data = ""
    cmnd = './wfbot.sh stat'
    subprocess.call(cmnd.split(),shell=False)
    time.sleep(2)
    cmnx = 'sort stat -o stat'
    subprocess.call(cmnx.split(),shell=False)
    time.sleep(1)
    with open('stat','r') as f:
      for line in f:
       data+=line.rjust(30,' ')
    f.close()
    print(data)
    ndata = re.sub(' +', ' ', data)
    yield from bot.say('```'+ ndata + '```')
    os.remove('stat')
with open('disc.cfg', 'r') as myfile:
   token=myfile.read().replace('\n', '')
bot.run(token)
 

