#!/bin/bash
    
   code_clone(){
	   echo "Cloning the Django app ....."
	   git clone https://github.com/kalyanisalalkar/django-notes-app.git
   }

   install_requirements(){
	   echo "Install dependencies"
	   sudo apt-get update
	   sudo apt-get install -y docker.io nginx docker-compose
   }

   required_restart(){
	  
	   sudo systemctl enable docker
	   sudo systemctl enable nginx
	   sudo systemctl restart docker
	   sudo usermod -a -G docker $USER
          
   }

   deploy(){
            docker build -t notes-app .
            #docker run -d --name django-notes-app -p 8000:8000 notes-app:latest
            docker-compose up -d
    }

   echo "------------------Delpoyment stared ----------------------"
     
        if ! code_clone;then
		echo "The code directory already exits"
		cd django-notes-app
	fi

        if ! install_requirements;then
		echo "installation failed"
		exit 1
	fi

        if ! required_restart;then
		echo "System error occured"
		exit 1
	fi

        if ! deploy;then
		echo "Deployment failed"
		exit 1
	fi
   echo "------------------Deloyment Done ---------------------------"    	
