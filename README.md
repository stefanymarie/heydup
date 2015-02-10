para paspas ang up sa boxes. uncomment next 3 lines sa provision_from_bare.sh, then comment the rest, then package

remember to uncomment network settings in Vagrantfile & set NODES=1 when creating new base box

$> vagrant up

$> vagrant package --base $(cat .vagrant/machines/node1/virtualbox/id) ---output java.box
