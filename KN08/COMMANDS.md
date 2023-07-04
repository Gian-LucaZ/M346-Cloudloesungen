```
~ aws ec2 create-subnet --vpc-id vpc-081ec835f3EXAMPLE --cidr-block 172.31.100.0/16 --tag-specificationsResourceType=subnet,Tags=[{Key=Name,Value=sn-kn08}]

~ aws ec2 create-security-group --group-name "sg-webserver" --vpc-id vpc-081ec835f3EXAMPLE 
~ aws ec2 authorize-security-group-ingress --group-id `sgID-dbserver` --protocol http --port `80`

~ aws ec2 create-security-group --group-name "sg-dbserver" --vpc-id vpc-081ec835f3EXAMPLE 
~ aws ec2 authorize-security-group-ingress --group-id `sgID-dbserver` --protocol tcp --port `8111`

~ aws ec2 allocate-address --address 172.31.100.10
~ aws ec2 allocate-address --address 172.31.100.11

~ aws ec2 create-network-interface --subnet-id iWebserver --description "interface webserver" --groups sg-webserver --private-ip-address 172.31.100.10
~ aws ec2 create-network-interface --subnet-id iDbserver --description "interface dbserver" --groups sg-dbserver --private-ip-address 172.31.100.10

~ aws ec2 run-instances \
    --image-id ami-0abcdef1234567890 \
    --instance-type t2.micro \
    --count 1 \
    --network-interfaces iWebserver \
    --key-name gianluca1 \
    --user-data file://webinit-server.txt
    
~ aws ec2 run-instances \
    --image-id ami-0abcdef1232345662 \
    --instance-type t2.micro \
    --count 1 \
    --network-interfaces iDbserver \
    --key-name gianluca1 \
    --user-data file://webinit-db.txt


```