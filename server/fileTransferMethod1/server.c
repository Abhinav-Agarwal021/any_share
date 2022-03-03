#include<sys/socket.h>
#include<sys/types.h>
#include<netdb.h>
#include<stdio.h>
#include<string.h>
#include<arpa/inet.h>
#include<unistd.h>
#include<stdlib.h>
#include<netinet/in.h>
#include<errno.h>
#include<fcntl.h>
#define PORT "10001"
#define BACKLOG 10
#define FILEBUF_SIZE 10000

void* get_in_addr(struct sockaddr* sa){
    if(sa->sa_family==AF_INET){
        return &(((struct sockaddr_in*)sa)->sin_addr);
    }
    return &(((struct sockaddr_in6*)sa)->sin6_addr);
}

int sendFile(int socketfd, int clientfd, char* filename){
    char fileBuf[FILEBUF_SIZE]; 
    if(!fork()){
            close(socketfd);
            int filefd = open(filename,O_RDONLY);
            if(filefd==-1){
                fprintf(stderr,"Failed to open the file");
                return -1;
            }
            if(read(filefd,fileBuf,sizeof(fileBuf))==-1){
                perror("read");
                return -1;
            }
            if(send(clientfd,fileBuf,sizeof(fileBuf),0)==-1){
                perror("send");
            }
            
            close(clientfd);
            exit(0);
        }
}

int main(){
    int socketfd,status,yes=1,clientfd;
    struct addrinfo addrStruct,*serverInfo,*p;
    struct sockaddr_storage client_addr;
    socklen_t sin_size;
    memset(&addrStruct,0,sizeof(addrStruct));
    addrStruct.ai_family = AF_UNSPEC;
    addrStruct.ai_socktype = SOCK_STREAM;
    addrStruct.ai_flags = AI_PASSIVE;
    char ipstr[INET6_ADDRSTRLEN];
    status = getaddrinfo(NULL,PORT,&addrStruct,&serverInfo);
    if(status!=0){
        printf("%s\n",gai_strerror(status));
        return 1;
    }
    for(p=serverInfo;p!=NULL;p=p->ai_next){
        socketfd = socket(p->ai_family,p->ai_socktype,p->ai_protocol);
        if(socketfd==-1){
            perror("server: socket");
            continue;
        }
        if(setsockopt(socketfd,SOL_SOCKET,SO_REUSEADDR,&yes,sizeof(int))==-1){
            perror("setsockopt");
            exit(1);
        }
        if(bind(socketfd,p->ai_addr,p->ai_addrlen)==-1){
            close(socketfd);
            perror("server: bind");
            continue;
        }
        break;
    }
    freeaddrinfo(serverInfo);
    if(p==NULL){
        fprintf(stderr,"server: failed to bind");
        exit(1);
    }
    if(listen(socketfd,BACKLOG)==-1){
        perror("listen");
        exit(1);
    }
    puts("Server waiting for connections..");
    while(1){
        sin_size = sizeof(client_addr);
        clientfd = accept(socketfd,(struct sockaddr*)&client_addr,&sin_size);
        if(clientfd==-1){
            perror("accept");
            continue;
        }
        inet_ntop(client_addr.ss_family,get_in_addr((struct sockaddr*)&client_addr),ipstr,sizeof(ipstr));
        printf("Server got connection from %s\n",ipstr);
       
        if(sendFile(socketfd,clientfd,"dummy.txt")==-1){
            perror("sendfile");
            close(clientfd);
            continue;
        };
        close(clientfd);
    }
    return 0;
}