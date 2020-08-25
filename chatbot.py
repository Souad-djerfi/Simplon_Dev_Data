#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Aug 19 11:31:45 2020

@author: souad
"""
import random
from random import *
mot_clé=["père", "mère", "copain", "maman", "papa", "copine","amie", "ami", 'frère','soeur']
depart=["Bonjour, comment allez vous?","Bonjour, comment s est passée votre journée?","Bonjour, pourquoi venez vous me voir?"]
question=["Pourquoi me posez-vous cette question ?", "Oseriez-vous poser cette question à un humain ?", "Je ne peux malheureusement pas répondre à cette question."]
humeur=["bien","pas bien", "content", "contente","heureux","heureuse","malheureux","malheureuse","en forme","triste","mal","pas du tout bien"]
quitter=["vous quitter", "au revoir", "à bientôt", "je vous remercie"]
proposition=["J’entends bien.","Je sens une pointe de regret.","Est-ce une bonne nouvelle ?", "Oui, c’est ça le problème.","Pensez-vous ce que vous dites ?", "Hum... Il se peut."]

print(depart[randint(0,len(depart)-1)])


lui=input( )


while(lui):

    for mot in mot_clé:
        if mot in lui: 
            question1=["comment va  votre "+mot, "la relation avec  votre "+mot+" vous pose t elle probleme","pourquoi pensez vous en ce moment a votre "+ mot+"?"]
            print(choice(question1))
            lui=input()
    for mot1 in humeur:
        if mot1 in lui:
            question2=["pourquoi vous êtes "+mot1,"dites moi tout","racontez moi, je vous écoute"]
            print(choice(question2))
            lui=input()
            
    for mot2 in quitter:
        if mot2 in lui:
            
            question3=["etes vous sûr de vouloir quitter?", "vous allez partir?"]  
            print(choice(question3))
            lui=input()
            if lui.find("oui")!=-1:
                print("à bientôt")
                break
            else:
                question4=["voulez vous qu'on parle d'autre chose?","avez vous autre chose à me raconter"]
                print (choice(question4))
                lui=input()
        
    if lui.find("?") !=-1:
          print(choice(question))      
          lui=input()
          
    elif lui.find("!")!=-1:
        print(choice(proposition))
        lui=input()
        
   
    
    
     