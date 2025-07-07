# vim: filetype=sh

command_exists () {
      type "$1" &> /dev/null ;
      #echo "command $1 status $?"
}

update-tmux-environment () 
{ 
  if command_exists dbus-launch ; then
    export $(dbus-launch)
  fi

  echo -n "Updating to latest tmux environment...";
  export IFS=",";
  for line in $(tmux showenv -t $(tmux display -p "#S") | tr "\n" ",");
  do
    if [[ $line == -* ]]; then
      unset $(echo $line | cut -c2-);
    else
      export $line;
  fi;
  done;
  unset IFS;
  echo "Done"
}

killport() {
    lsof -i tcp:$1 | awk 'NR!=1 {print $2}' | xargs kill -9
}

