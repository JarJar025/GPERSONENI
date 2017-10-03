#include <stdio.h>
#include <stdlib.h>
void erreurSystemeFin(const char* msg,int valeur_retour)
  {
  perror(msg);
  exit(valeur_retour);
  }

main()
{
   int nbreProc=10;
   int i=0;

   pid_t tab_fils[nbreProc];
   pid_t pid;
   int status;


   for(i; i < nbreProc  ; i++)
   {
    switch (tab_fils[i]=fork()) {
       case (pid_t) -1 : erreurSystemeFin("",1);   /* break inutile */
       case (pid_t)  0 :   /* on est dans le processus fils */
                        tab_fils[i] = getpid();
                        printf("\n........................................................................\n" );
                        printf("\tCreation du Zombie N° %d \n",i+1 );
                        printf("\tFILS : je suis le processus zombie %d de pere %d\n",getpid(),getppid());
                        exit(1);                           /* idem */
       default:
                sleep(1);
                printf("PERE : valeur de fork N° %d \n",tab_fils[i]);
    }


  }

   printf ("\n------------------------------------------------------------------------\n"     );
   printf ("  Vous avez %d processus zombies qui se baladent sur votre système.     \n", i);
   printf ("  Ils vont errer pendant %d sec, vous pouvez les observer avec ps -aux. \n",60);
   printf ("------------------------------------------------------------------------\n"     );

   // Temps d'attente, en seconde, pour observer les zombies
   sleep(60);
   printf("\n");


            
   for(int i = 0 ; i < nbreProc ; i++)
   {
    sleep(2);
    pid=wait(NULL);
    printf("Le Zombie de PID = %d a disparu \n",pid );
   }



   printf ("\n------------------------------------------------------------------------\n");
   printf ("  L'invasion zombie est terminé.\n"                                        );
   printf ("  Le processus père est encore observable %d secondes.\n", 10           );
   printf ("------------------------------------------------------------------------\n");

   sleep(10);
}
