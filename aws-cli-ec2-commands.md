```
$ aws ec2 describe-instances --instance-ids i-00817525a42680551 --filters Name=instance-state-name,Values=running --profile wasp-admin | jq -r '.Reservations|.[0].Instances|.[0].PublicDnsName' 

ec2-18-236-183-34.us-west-2.compute.amazonaws.com
```
```
$ aws ec2 stop-instances --instance-ids i-00817525a42680551 --profile wasp-admin
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
```
$ aws ec2 start-instances --instance-ids i-00817525a42680551 --profile wasp-admin
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
```
$ aws ec2 wait instance-running --instance-ids i-00817525a42680551 --profile wasp-admin
```
```
$ aws ec2 describe-instance-status --instance-ids i-00817525a42680551 --profile wasp-admin
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