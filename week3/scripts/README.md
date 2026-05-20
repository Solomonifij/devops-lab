# Week 3 Scripts

This folder contains two bash automation scripts built as part of a DevOps lab.

---

## 1. disk_alert.sh

### What it does
- Checks disk usage across all mounted filesystems
- Logs usage with a timestamp to `/var/log/disk_monitor.log`
- Prints an ALERT message for any filesystem above 80% capacity

### How to configure
1. Copy the script to `/usr/local/bin/`:
```bash
   sudo cp disk_alert.sh /usr/local/bin/disk_alert.sh
   sudo chmod +x /usr/local/bin/disk_alert.sh
```

2. To change the alert threshold, edit this line in the script:
```bash
   THRESHOLD=80
```

3. Schedule it to run every 30 minutes via cron:
```bash
   sudo crontab -e
```
  
*/30 * * * * /usr/local/bin/disk_alert.sh


### IAM Permissions Needed
None — this script runs locally on the server and does not interact with AWS.

---

## 2. backup.sh

### What it does
- Creates a compressed tarball (`.tar.gz`) of the `~/devops-lab` folder
- Adds a timestamp to the filename so backups never overwrite each other
- Uploads the tarball to an AWS S3 bucket using the AWS CLI

### How to configure
1. Open the script and update the bucket name:
```bash
   nano backup.sh
```
   Change this line:
```bash
   BUCKET="s3://your-bucket-name"
```

2. Make it executable:
```bash
   chmod +x backup.sh
```

3. Run it:
```bash
   ~/backup.sh
```

4. To schedule daily backups at 2AM via cron:
```bash
   sudo crontab -e
```
  
0 2 * * * /home/ubuntu/backup.sh

### IAM Permissions Needed
The AWS IAM user running this script must have the following permissions:

| Permission | Policy |
|---|---|
| Upload files to S3 | `AmazonS3FullAccess` or a custom policy with `s3:PutObject` |
| List S3 buckets (optional) | `s3:ListBucket` |

Attach the policy in **AWS Console → IAM → Users → your-user → Add Permissions**.

---

## Author
Your Name — DevOps Lab Week 3
