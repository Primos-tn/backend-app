
    Execute the following command to add the APT repository to your /etc/apt/sources.list.d:

    echo 'deb http://www.rabbitmq.com/debian/ testing main' |
            sudo tee /etc/apt/sources.list.d/rabbitmq.list

    (Please note that the word testing in this line refers to the state of our release of RabbitMQ, not any particular Debian distribution. You can use it with Debian stable, testing or unstable, as well as with Ubuntu. We describe the release as "testing" to emphasise that we release somewhat frequently.)
    (optional) To avoid warnings about unsigned packages, add our public key to your trusted key list using apt-key(8):

    wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc |
            sudo apt-key add -

    Our public signing key is also available from Bintray.
    Run the following command to update the package list:

    sudo apt-get update

    Install rabbitmq-server package:

    sudo apt-get install rabbitmq-server

