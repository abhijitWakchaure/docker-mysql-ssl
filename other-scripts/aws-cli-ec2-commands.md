# EC2 helper commands

## Get public DNS of EC2 instance based on instance ID

```bash
$ aws ec2 describe-instances --instance-ids i-00817525a42680551 --filters Name=instance-state-name,Values=running --profile awakchau-root | jq -r '.Reservations|.[0].Instances|.[0].PublicDnsName' 

ec2-18-236-183-34.us-west-2.compute.amazonaws.com
```

## Stop EC2 instance based on instance ID

```bash
$ aws ec2 stop-instances --instance-ids i-00817525a42680551 --profile awakchau-root
{
    "StoppingInstances": [
        {
            "CurrentState": {
                "Code": 64,
                "Name": "stopping"
            },
            "InstanceId": "i-00817525a42680551",
            "PreviousState": {
                "Code": 16,
                "Name": "running"
            }
        }
    ]
}
```

## Start EC2 instance based on instance ID

```bash
$ aws ec2 start-instances --instance-ids i-00817525a42680551 --profile awakchau-root
{
    "StartingInstances": [
        {
            "CurrentState": {
                "Code": 0,
                "Name": "pending"
            },
            "InstanceId": "i-00817525a42680551",
            "PreviousState": {
                "Code": 80,
                "Name": "stopped"
            }
        }
    ]
}
```

## Wait for EC2 instance to get into running state after starting based on instance ID

```bash
$ aws ec2 wait instance-running --instance-ids i-00817525a42680551 --profile awakchau-root
```

## Get details of EC2 instance status based on instance ID

```bash
$ aws ec2 describe-instance-status --instance-ids i-00817525a42680551 --profile awakchau-root
{
    "InstanceStatuses": [
        {
            "AvailabilityZone": "us-west-2a",
            "InstanceId": "i-00817525a42680551",
            "InstanceState": {
                "Code": 16,
                "Name": "running"
            },
            "InstanceStatus": {
                "Details": [
                    {
                        "Name": "reachability",
                        "Status": "passed"
                    }
                ],
                "Status": "ok"
            },
            "SystemStatus": {
                "Details": [
                    {
                        "Name": "reachability",
                        "Status": "passed"
                    }
                ],
                "Status": "ok"
            }
        }
    ]
}
```
