#!/bin/bash
random_select_docker=`docker ps | shuf -n1  | awk {'print $10'}`
echo $random_select_docker
status_code=`docker logs $random_select_docker | tail -n1 | awk {'print $20'}`
echo $status_code" will be killed!"
if [ $status_code = "400." ];
then
	docker kill $random_select_docker
fi
running_num=`docker ps | wc -l`
echo "running docker number : "$running_num
if [ $running_num -gt 15 ];
then
	exit 1
fi
account=`shuf -n1 /home/ec2-user/bot/account`
dockername=$account$(date +%s)
echo "selected accout : "  $account " / docker name :" $dockername
docker run -d -e IG_USER=$account -e IG_PASSWORD=Tsinghua0988 --name $dockername 5be17c8bd09d
