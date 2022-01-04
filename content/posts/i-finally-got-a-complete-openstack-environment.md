---
title: "I Finally Got a Complete Openstack Environment"
date: 2022-01-04T08:33:26-05:00
draft: false
---
Well, it was bound to happen at some point. I got a complete OpenStack environment up and running with all the
components I wanted, including Ceph (for live migrations and HA). You might be thinking to yourself I should
sound happier, and you are right. The performance for this new system is abysmal, at least as far as Ceph goes.
14MB/s on average, where an instance on the local storage is about 85MB/s. I would expect at least a similar
number from Ceph, but that doesn't appear to be the case. This was the same thing when I did the 3-node setup
with PetaSAN last year, the performance from 12x Intel DC SSDs on 10G networking across 3 nodes was like
60-70MB/s, where the raw disks in a RAID10 crested 1GB/s. Not really sure what I am doing wrong here, but it is
obviously something. I need to go back to the drawing board I think and re-provision these nodes with just
Ubuntu and then install cephadm by itself and see what I can come up with. I think I will be better able to test
and tune that way rather than messing around in these individual containers.

In any case, progress is progress!

[Cross-posted from my blog at 
seanperryman.com](https://seanperryman.com/2022/01/04/I-Finally-Got-A-Full-OpenStack-Environment.html)
