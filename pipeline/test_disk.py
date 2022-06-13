#!/usr/bin/env python3
# Edited from max tool

import sys
import time
import argparse
import subprocess
import os
import datetime
import re

Description = """
Tool to check the disk usage
"""

def main():
    parser = argparse.ArgumentParser(
        description=Description, formatter_class=argparse.RawTextHelpFormatter)
    args = parser.parse_args()

    # command = "/usr/bin/time -v cp /home/rossi.m/data/tests/disk_logger/sample.fastq_HG_10.fa_25.sam /home/rossi.m/data/tests/disk_logger/copy_test"
    command = "/usr/bin/time -v -o /blue/boucher/yu.hong/logs/lz_77/yeast.res /blue/boucher/yu.hong/CST_LZ77/build/src/lz_77_test /blue/boucher/yu.hong/CST_LZ77/data/Chr_19_2504_256.fasta"
    p = subprocess.Popen(command.split(), shell=False)



    max_disk = 0

    while p.poll() is None:
        try:
            pids_o = subprocess.check_output(
                "pstree -p {pid} | grep -o '([0-9]\+)' | grep -o '[0-9]\+'".format(pid=p.pid), shell=True)
        except subprocess.CalledProcessError as e:
            raise RuntimeError("command '{}' return with error (code {}): {}".format(e.cmd, e.returncode, e.output))
        pids = re.findall('\d+', pids_o.decode("utf-8"))

        for pid in pids:
            try:
                opened_files = subprocess.check_output(
                    "readlink -f /proc/{pid}/fd/*".format(pid=pid), shell=True).decode('utf-8').rstrip().split('\n')

                # print(opened_files)
                disk = 0
                for f in opened_files[3:]:
                    disk += os.path.getsize(f)
                max_disk = max(disk, max_disk)
            except subprocess.CalledProcessError as e:
                print("Miss last readlink")
            # time.sleep(2)

    print(max_disk)


if __name__ == '__main__':
    main()
