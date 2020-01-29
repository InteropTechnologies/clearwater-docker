#Delete all existing local containers
tag=$1
sudo rm -rf /var/lib/docker/*
sudo systemctl restart docker
for i in base astaire cassandra chronos bono ellis homer homestead homestead-prov ralf sprout 
do 
  docker build -t clearwater/$i $i 
  docker tag clearwater/$i:latest harbor.iot1.com/clearwater/$i:$tag
  docker push harbor.iot1.com/clearwater/$i:$tag
done

