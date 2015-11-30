import subprocess
import os
import setup_util

def cmd(cmd):
  subprocess.check_call(cmd, shell=True, cwd="zotonic")


def start(args):

  try:
    # Install Zotonic
    if not os.path.exists("zotonic/zotonic"):
      cmd("git clone https://github.com/zotonic/zotonic.git")
      cmd("ln -snf ../../../site/ zotonic/priv/sites/techempower")
      cmd("cd zotonic && make")
      cmd("cd site && cp config.in config")
      setup_util.replace_text("zotonic/site/config", "DBHOST", args.database_host)

    cmd("zotonic/bin/zotonic start")
    return 0
  except subprocess.CalledProcessError, e:
    print e
    return 1

def stop():
  try:
    cmd("zotonic/bin/zotonic stop")
    return 0
  except subprocess.CalledProcessError:
    return 1


if __name__ == "__main__":
  args = object()
  print args
  args.database_host = '127.0.0.1'
  print args
  start(args)
