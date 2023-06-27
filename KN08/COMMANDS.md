```
~ aws ec2 create-subnet --vpc-id vpc-081ec835f3EXAMPLE --cidr-block 172.31.100.0/16 --tag-specificationsResourceType=subnet,Tags=[{Key=Name,Value=sn-kn08}]

~ aws ec2 create-security-group --group-name "sg-webserver" --vpc-id vpc-081ec835f3EXAMPLE 
~ aws ec2 authorize-security-group-ingress --group-id `sgID-dbserver` --protocol tcp --port `8111`

~ aws ec2 create-security-group --group-name "sg-dbserver" --vpc-id vpc-081ec835f3EXAMPLE 
~ aws ec2 authorize-security-group-ingress --group-id `sgID-dbserver` --protocol tcp --port `8111`

aws ec2 allocate-address --address 172.31.101.0
```