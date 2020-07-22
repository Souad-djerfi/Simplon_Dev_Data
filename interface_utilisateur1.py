# -*- coding: utf-8 -*-
"""
Éditeur de Spyder

Ceci est un script temporaire.
"""
import sqlalchemy 
import pandas as pd
import calendar
import datetime

from sqlalchemy  import create_engine
#engine=create_engine('mysql+pymysql://simplon:Simplon2020@localhost:3306/simplon')
#jeu_vid=pd.read_sql_query('select * from jeux_video', engine)
#print(jeu_vid)


engine_assur=create_engine('mysql+pymysql://simplon:Simplon2020@localhost:3306/assur_auto')
#pd.read_sql_query( 'ALTER TABLE `CLIENT` MODIFY COLUMN `CLIENT_ID` INTEGER  NOT NULL  AUTO_INCREMENT;', engine_assur)


#******************************************SAISIR UN CLEITN***************************************************
print("********************************VEUILLEZ ENTRER LES INFORMATIONS DU CLIENT*******************************")

max_id=pd.read_sql_query('SELECT max(CLIENT_ID) as max FROM CLIENT', engine_assur)['max']
#print(max_id[0])
cl_nom=input('tapez le nom du client : ')
cl_prenom=input('tapez le prenom du client : ')
cl_adresse=input('tapez l,adresse du client : ')
cl_code_pos= input('tapez le code postal du client : ')

while not(cl_code_pos.isdigit()):
     print("veuillez saisir un chiffre")
     cl_code_pos= input('                 tapez le code postal du client : ')
        
cl_ville=input('tapez la ville du client : ')
cl_tel= input('tapez le num de tel du client : ')
cl_email=input('tapez lemail du client : ')
engine_assur.execute('insert into CLIENT (CLIENT_ID,CLIENT_NOM, CLIENT_PRENOM, CLIENT_ADRESSE, CLIENT_CODE_POST, CLIENT_VILLE, CLIENT_TEL, CLIENT_EMAIL)values(%s,"%s","%s","%s","%s","%s","%s","%s");' %(max_id[0]+1, cl_nom.upper(),cl_prenom.upper(),cl_adresse,cl_code_pos, cl_ville, cl_tel, cl_email ))


#*********************************************SAISIR UN CONTRAT******************************************************
print("********************************VEUILLEZ ENTRER LES INFORMATIONS DU CONTRAT*******************************")

max_id_c = pd.read_sql_query('select max(contrat_id)  as max from CONTRAT ', engine_assur)['max']
#print(max_id_c[0])
from datetime import datetime
c_date = datetime.today().strftime("%Y-%m-%d")

c_categorie= input("entrer la catégorie du contrat")
c_bonus = input ("entrer le bonus")
c_malus = input ("entrer le malus")
engine_assur.execute('insert into CONTRAT (CONTRAT_ID, CONTRAT_DATE, CONTRAT_CATEGORIE, CONTRAT_BONUS, CONTRAT_MALUS, AGENC_ID_FK, CLIEN_ID_FK) values (%s,"%s", "%s","%s","%s", %s, %s);' %(max_id_c[0]+1, c_date, c_categorie,c_bonus, c_bonus,  1, max_id[0]+1 ))

print (" *************************la saisie du client et contrat s est bien déroulée *************************************")