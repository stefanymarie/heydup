# sudo apt-get update -y
# sudo apt-get install openjdk-7-jre openjdk-7-jdk -y
# sudo apt-get install ssh rsync -y

sudo useradd -s /bin/bash -m hduser
sudo adduser --ingroup hadoop hduser
echo "hduser:hduser" | sudo chpasswd

echo "hduser ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/hduser
sudo chmod 0440 /etc/sudoers.d/hduser

su hduser <<EOF
mkdir -p /home/hduser/.ssh
ssh-keygen -t dsa -P '' -f /home/hduser/.ssh/id_dsa
cat /home/hduser/.ssh/id_dsa.pub >> /home/hduser/.ssh/authorized_keys

cd /usr/local/
sudo cp /vagrant/hadoop-2.6.0.tar.gz /usr/local
sudo tar -xf /usr/local/hadoop-2.6.0.tar.gz
sudo mv /usr/local/hadoop-2.6.0 /usr/local/hadoop
sudo rm /usr/local/hadoop-2.6.0.tar.gz
sudo chown -R hduser:hduser /usr/local/hadoop
sudo chmod +x -R /usr/local/hadoop

echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" >> /home/hduser/.bashrc
echo "export HADOOP_PREFIX=/usr/local/hadoop" >> /home/hduser/.bashrc
echo "export PATH=$PATH:/usr/local/hadoop/bin" >> /home/hduser/.bashrc
source /home/hduser/.bashrc
EOF