# Voice Controlled Hubot

*Notice* Currently in _alpha_ state, wait a few more days or start hacking along

This repository will help you extend your [Hubot](http://hubot.github.com) with speech capabilities.

## Installing

Make sure you have to following things installed:

- Mac OS X only (for now, it uses the `say` command)
- Brew
- Node.js
- Ruby

Copy all the files in this repo in your existing Hubot folder or create one like so:
```bash
bin/hubot --create Cece
```

Then run the following commands to install any missing dependencies
```bash
npm install
brew install ffmpeg
bundle install
```

This repository comes with an automator script called Cece.app.
You will need to edit this script to match your Hubot location.
What it basically has to do is:
```bash
# load zsh or bash environment
cd /to-your-hubot-location
ruby listen.rb
```

*Bonus* You can set the voice to female by going `System Preferences -> Accessibility -> "Open VoiceOver Utility"`
Then move down to `Speech` and choose `Vicki` in the Voice table.

## Testing

Run the automator script, or `ruby listen.rb` manually in your Hubot folder.
Wait for the `Please speak` and then say `ping` loud and clear.
After a few seconds you should hear the hubot say `PONG`.

Check the `chat.log` to see the commands you've given to Hubot. 
This can be helpful to determine if it properly understood your recording.

## More fun

Now add as many hubot scripts as you can, check the [catalog](http://hubot-script-catalog.herokuapp.com).

## TODO
- Use socket.io instead of hacking the Shell adapter

## Killing stuck Hubots
If it didn't make sense of your command, the Hubot will still be waiting for a command. 
```bash
ps -ef | grep hubot | grep -v grep | awk '{print $2}' | xargs kill
```