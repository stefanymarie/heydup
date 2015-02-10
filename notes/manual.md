sudo su hduser
cd $HADOOP_PREFIX

mkdir -p /usr/local/hadoop/tmp
sudo cp -R /vagrant/input /usr/local/hadoop/tmp/

<!-- for master only
sudo cp /vagrant/hadoop-config/* /usr/local/hadoop/etc/hadoop/
-->

<!-- for node2 only
sudo cp /vagrant/hadoop-config-slave/*.xml /usr/local/hadoop/etc/hadoop/
-->

sudo vim /etc/hosts
<!-- copy-paste
192.168.0.11    node1
192.168.0.12    node2
-->

<!-- for master only
ssh-copy-id -i $HOME/.ssh/id_dsa.pub hduser@node2
-->

echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh

sudo rm -rf /hadoop
sudo mkdir -p /hadoop/hadoop-hduser
sudo chown -R hduser:hduser /hadoop

<!-- the rest: for master only -->
hdfs namenode -format
sbin/start-dfs.sh
jps

hdfs dfs -mkdir -p /user/hduser
hdfs dfs -mkdir input

hdfs dfs -put tmp/input/* input
hdfs dfs -ls input