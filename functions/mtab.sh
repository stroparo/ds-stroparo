mtab () {
  egrep -v 'truec|cgroup|/sys|tmpfs|robo3t|KeePass|/snap/core' /etc/mtab
}
