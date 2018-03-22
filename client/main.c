/*
* Modulo che si occupa di ricevere messaggi sulla porta TCP 1808 
* status return:
* -4 Errore di scrittura sul socket
* -3 Errore di accettazione apertura nuovo socket
* -2 Errore di lettura dal socket
* -1 Errore durante l'apertura della socket
* 0 esecuzione terminata con successo
*/
#include <stdio.h>
#include <sys/types.h> 
#include <sys/socket.h>
#include <netinet/in.h>
#include<arpa/inet.h>


int main(int argc, char *argv[])
{
     int sockfd, newsockfd, portno, clilen;
     int port = 1808;
     char buffer[256];
     struct sockaddr_in serv_addr, cli_addr;
     int n;

     sockfd = socket(AF_INET, SOCK_STREAM, 0);
     if (sockfd < 0){ 
        perror("ERROR opening socket");
        exit(-1);
     }

     bzero((char *) &serv_addr, sizeof(serv_addr));
     serv_addr.sin_family = AF_INET;
     serv_addr.sin_addr.s_addr = INADDR_ANY;
     serv_addr.sin_port = htons(port);

     if (bind(sockfd, (struct sockaddr *) &serv_addr,
              sizeof(serv_addr)) < 0) 
              perror("ERROR on binding");

     listen(sockfd,0);
     clilen = sizeof(cli_addr);
     newsockfd = accept(sockfd, (struct sockaddr *) &cli_addr, &clilen);
     
     printf("Client infos:\n IP: %d\nPort: %d\n", cli_addr.sin_addr.s_addr, cli_addr.sin_port);

     if (newsockfd < 0){ 
          perror("ERROR on accept");
        exit(-3);
     }
     bzero(buffer,256);
     n = read(newsockfd,buffer,255);
     if (n < 0){ 
        perror("ERROR reading from socket");
        exit(-2);
     }

     printf("Here is the message: %s\n",buffer);

     n = write(newsockfd,"I got your message",18);

     if (n < 0){ 
        perror("ERROR writing to socket");
        exit(-4);
     }
     return 0; 
}
