#!/usr/bin/env python

# Run StarCraft II via Optirun. Requires jumping through hoops because
# the first executable launches a couple of subprocesses so we need to
# keep Optirun alive for those.

import sys
import subprocess
import time
import os

if 'RUNNING_WITH_OPTIRUN' in sys.argv:
  home_dir = os.environ['HOME']
  subprocess.check_call(['wine', home_dir + '/.config/wine/drive_c/Program Files/StarCraft II/StarCraft II.exe'])
  # Wait for initial launcher subprocess to be called. It handles patch updates and such.
  time.sleep(10)
  # Keep alive until the launcher terminates.
  while subprocess.Popen(['pidof', 'Blizzard Launcher.exe'], stdout=subprocess.PIPE).communicate()[0]:
    time.sleep(5)
    # Wait for game executable to be called.
  time.sleep(5)
  # Keep alive until the game executable terminates.
  while subprocess.Popen(['pidof', 'SC2.exe', 'Agent.exe'], stdout=subprocess.PIPE).communicate()[0]:
    time.sleep(5)
else:
  # Call myself with optirun.
  subprocess.check_call(['optirun', sys.argv[0], 'RUNNING_WITH_OPTIRUN'])
