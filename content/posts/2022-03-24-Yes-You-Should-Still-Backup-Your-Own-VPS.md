---
title: "Yes, You Should Still Backup Your Own VPS"
date: 2022-03-24T07:52:24-04:00
draft: true
---
This topic is probably something that no one wants to talk about: Backing up your VPS. Many of us figure that 
the provider we are paying for service will take care of this, but the truth is that very few do. Even those 
that do, the backup you can restore or otherwise access might not be very current. For example, once upon a time 
RamNode would back up their OpenVZ VPS just for a little added protection. The caveat here is that it was so 
slow and so far behind, if your VPS hadn't been around for a few months already there would be no backup for it. 
That said, sometimes having any backup at all is better than none, and so we take what we can get. I'm here to 
tell you that there is a better way! In this video I will talk about a couple of easy ways to back your data up, 
starting with completely cloud based and ending with a simple process that you can just download to your local 
machine. 
## Tarsnap
By far, the easiest backup method for a Linux-based VPS is Tarsnap. Tarsnap is a command-line based backup 
utility capable of both full and incremental backups. Tarsnap installs as an executable on your system and is 
executed with a cronjob on the schedule that you want. Getting started with Tarsnap is easy. All you need to do 
is install Tarsnap (I'll leave a link to the Getting Started document in the description), set up your 
configuration file, sign up for a Tarsnap account, depost funs into your account, and register the machine you 
are using Tarsnap on. The tarsnap-keygen utility registers a machine with the Tarsnap servers which confirms its 
usage should be charged to your account, and generates cryptographic keys that are used to store, restore, and 
delete the protected machine's backups. 
Once you have Tarsnap configured and registered, you can create a script that runs the utility with the 
appropriate flags and paths, then add that script as a cronjob to run on the schedule that you want. The initial 
Tarsnap backup you execute will be a full backup encompassing everything available to it (you can point it at 
the / root directory, or a subdirectory like /home if you want to get more granular), and subsequent backups 
will just target the blocks that have changed in the time since the last backup. You can back up as little or as 
often as you would like.  
The use case presented on the tarsnap.com website shows an initial backup of about 7.5GB, a relatively small 
amount of changed blocks that is made smaller by compressing before upload. It shows that for the thousands of 
incremental backups stored, the user is paying less than $5 per month. This is possible due to a couple of 
factors. The first is that while Tarsnap does charge for storage and ingress (incoming data), once that data is 
stored on their system it can live there for $0.25/GB/Mo. The second is that Tarsnap is taking incremental 
backups of changed blocks, and compressing them prior to upload. This saves you both on ingress fees charged at 
$0.25/GB, as well as long-term storage fees. This also gives you the capacity to restore from multiple backup 
points instead of just from the latest full backup. 
## Duplicity
For those of us who are already paying for a storage server, or otherwise want to control their own storage 
infrastructure, there is an OpenSource self-hosted system like Tarsnap called Duplicity. Duplicity describes 
itself as a tool that backs up directories by producing encrypted tar-format volumes and uploading them to a 
remote or local file server. Duplicity uses librsync, meaning incremental archives are space-efficient and only 
target parts of files that have changed since the prior backup. Similar to Tarsnap, the first backup is a full 
backup, and subsequent backups are incremental and much smaller in nature.
Duplicity supports most Cloud-native storage services including Amazon S3, Backblaze B2, DropBox, Google Drive, 
Mega, Microsoft Onedrive, and Rackspace Cloudfiles. I have personally used this with Backblaze B2 and it worked 
perfectly. Duplicity also supports transfers using traditional protocols like ftp, sftp, ssh and scp, and rsync, 
meaning you could set up an account on an existing Linux storage storage and use it to store your data. In my 
case I have a storage VPS that I used for a transfer.sh instance. I've set up a user account on here for backing 
up, and use Duplicity to off-site data to this server. Even having another VPS with the same provider is better 
than nothing, but in most cases you would want to be geographically diverse if not also provider diverse. 
Keeping things separate is the best way to ensure that a failure, or a scenario like the OVH datacenter fire, 
doesn't take out your server and your backups. 
## Download Your Own Data
This method is, admittedly, the hardest to stick with but also it is the least expensive. Downloading a copy of 
your own data to your local machine is not necessarily automatable (is that a word?), nor is it particularly 
easy or fun to do, but desperate times call for desperate measures. This method of backup is most often 
undertaken right after a server is set up and ready to go. Once you have all of your services in place and 
configured, your website or your minecraft server up and running, at that point you download a copy of all the 
pertinent files. 
You will want to make sure you do things like take a dump of the MySQL database, and capture any and all files 
that would be required to get the server running on a new VPS. Keep in mind things like configurations in the 
/etc directory, files in the /opt and /var directories, and stuff in the /home and /root directories. This 
assumes that your provider doesn't have a "Quick Backup" or snapshot option available. If they do, taking a 
snapshot or a backup and downloading locally is a good option. 
Obiously this isn't the easiest way to keep your files safe, but as I said before some times having anything at 
all is better than the alternative. If your provider experiences a hardware failure and you lose your data, 
whatever credit they offer you (if any) will be of little use if you have none of your data available to 
restore. Providers typically account for this by have extra compatible hardware on-site that can be swapped out. 
Deploying similar or the same servers for nodes in a cluster facilitates this nicely, giving the ability to swap 
a motherboard, power supply, or even a whole chassis. Most datacenters have staff on-site 24/7 who are capable 
of performing hardware reconfiguration, though in some cases they are only staffed during normal business hours.
## Conclusion
Data loss on a provider node is exceedingly rare. Most providers use a RAID level with some form of fault 
tolerance, if not a more tolerant system, to prevent such loss. Often times dropping a node results in 
datacenter staff just moving the disks over to a spare chassis and you are back in business with some minor 
configuration changes. Given this, there are many other ways to suffer data loss not at the hands of a provider. 
If you have used SolusVM before, you might have noticed that "Reinstall" button. You would be surprised how many 
people think that this will overlay a new operating system and leave all your data in tact. Likewise, a bad or 
failed update could lead to an irrecoverable kernel panic, or at least one that is beyond your ability to 
repair. Having your own backup is essential in these times, as recovering data from a failed VPS state is not 
always an option. 
