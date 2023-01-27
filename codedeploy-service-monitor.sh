#!/bin/bash

# check if the codedeploy-agent service is running
status=$(systemctl is-active codedeploy-agent.service)


if [ "$status" != "active" ]; then
    
    echo "codedeploy-agent service is not running"
    
    # Attepmt to restart the service
    
    echo "Restarting the codedeploy-agent service..."
    
    sudo systemctl restart codedeploy-agent.service
    
    sleep 5
    
    # Check if the service is still not running no running
    
    status=$(systemctl is-active codedeploy-agent.service)

    if [ "$status" != "active" ]; then

        # Attempt to install the service

        echo 

        if [ -f /home/ubuntu/code-deploy-script.sh ]; then

            echo "Installing the codedeploy"

            sh /home/ubuntu/code-deploy-script.sh

            sleep 90

            # check the status after installation

            status=$(systemctl is-active codedeploy-agent.service)

            if [ "$status" != "active" ]; then

                echo "codedeploy-agent service faild to start after installation."
            else
                echo "codedeploy-agent service statrted successfully"
            fi
        else
            echo "Script not found"
        fi
    else
        echo "Service is active and restart successfully"
    fi
else
    echo "codedeploy-agent service is running"
fi