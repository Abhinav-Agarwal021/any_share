FROM ubuntu:20.04
WORKDIR /anyshare
RUN apt-get update 
COPY . ./
RUN apt-get install python3-pip
RUN pip install -r requirements.txt
CMD ["python3","manage.py","runserver"]
EXPOSE 8000