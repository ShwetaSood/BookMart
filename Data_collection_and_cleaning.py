% Face API Data collection, cleaning (removal of stop words, pre-processing)
% Created csv file containing user info, books liked, categories of book

import json
import csv
import unicodedata
import string
import facebook
import requests
from urllib import urlopen
import json


token = 'CAACEdEose0cBAMQzTG1jPZCimz7cZBesmTbWOe4PTL9UOasKQmCTrfRiJ3JkV6KPiunWp7zSFNktBjoiAsmf6iOvLBjhZAuaqpCnm4enRMSFJbCYbG0707bXdywTpwA0ZBOLP5jlfdiu5SgAvuiuhXthZBvTYz3iAhZCZBxSTGxIDNEq1HNCBTqoteSTcLrpTb5EV2l3CDENVFMX9nVppA2'
E2ZBuGFbxHydHmh93IKE2maNdPM56mLrhBrX4EUDJlSVEmzKSCpRxbZBXTaNrZCguBUPV6A0Dv3qVBlZB9omGYY8mMpHnKae0kvNchr9nwFZBXJm70OfjMwXniZCogB7N5ffgePkk5risdukOoylxg7q7BvkDgj8bi49ZCdp0tMZBP7gWyphNfo'

me= '323644367787373'

url = 'https://graph.facebook.com/v2.5/'+me+'?fields=friends.limit(300)%7Bbooks%7Bdescription%2Ccategory%2Cname%7D%2Cgender%2Cname%2Ctelevision%7Bdescription%2Ccategory%2Cname%7D%2Clikes%7Bcategory%2Cdescription%2Cname%7D%7D&access_token='+ sneha_token
resp = urlopen(url).read()
data = json.loads(resp.decode('utf-8'))

print data
with open('OutputDataSneha.json', 'w') as outfile:
    json.dump(data['friends']['data'], outfile )

bookFile = open("booksInfo.csv", 'a')
writeBook = csv.writer(bookFile)

userFile = open("UserInfo.csv", 'a')
writeUser = csv.writer(userFile)

userIDFile = open("UserID.csv", 'r')	#write unoque IDS in file collected so far
readUserID = csv.reader(userIDFile)
listOfIds=[]
for row in readUserID:
	listOfIds.append(row[0])
userIDFile.close()
# print listOfIds

bookIDFile = open("BookID.csv", 'r')    #write unoque IDS in file collected so far
readBOOKID = csv.reader(bookIDFile)
listOfBookName=[]
for row in readBOOKID:
    listOfBookName.append(row[0])
bookIDFile.close()
# print listOfBookName

userIDwriteFile = open("UserID.csv", 'w')
writeUserID = csv.writer(userIDwriteFile)

bookIDwriteFile = open("BookID.csv", 'w')
writeBookID = csv.writer(bookIDwriteFile)

stopwords=["biography","fiction","non-fiction","mystery","detective","crime","thrilling","adventure","action","battle","murder","humorous","funny","humor","comedy","comic",
"love","romance","romantic","art","drama","horror","paranormal","travel","fantasy","wizard","wizardry",
"religion","religious","political","business","economics","poetry","poems","poem","science","mathematics","programming","coding","gre",
"technology","autobiography"]

di={} #GLOBAL TO CODE
cat_index={} #GLOBAL TO CODE
di[stopwords[0]]="auto/biography"
di[stopwords[1]]="fiction"
di[stopwords[2]]="non-fiction"
for i in range(3,5):
	di[stopwords[i]]="detective"
for i in range(5,11):
	di[stopwords[i]]="action"
for i in range(11,16):
	di[stopwords[i]]="comedy"
for i in range(16,19):
	di[stopwords[i]]="romance"
di[stopwords[19]]="art"
di[stopwords[20]]="drama"
for i in range(21,23):
	di[stopwords[i]]="horror"
di[stopwords[23]]="travel"
for i in range(24,27):
	di[stopwords[i]]="fantasy"
for i in range(27,29):
	di[stopwords[i]]="religion"
for i in range(29,32):
	di[stopwords[i]]="political&eco"
for i in range(32,35):
	di[stopwords[i]]="poem"
for i in range(35,41):
	di[stopwords[i]]="education"
di[stopwords[41]]="auto/biography"

k=0
for i in range(0,len(di)):
	w=di[stopwords[i]]
	if(w not in cat_index):
		cat_index[w]=k;
		k=k+1

with open('OutputDataAnkita.json') as json_data:
    d = json.load(json_data)
    json_data.close()    
    

    for data in d:
    	userId = str(data['id']) 
    	if userId in listOfIds:
    		continue
    	listOfBooksForUser=[]
    	categories = [0] * 16 #keeping 16 categories
    	listOfIds.append(userId)
    	userName = str(data['name'])
    	userGender = ''
    	if 'gender' in data:
    		userGender = str(data['gender'])
    	userbooks = ''
    	if 'books' in data:
    		booksData = data['books']['data']
    		numOfBooks = len (booksData)
    		for num_book in range(0,numOfBooks):
    			book = booksData[num_book]
    			if str (book['category']) == 'Book':
				bookName = book['name'].encode('utf-8')
    				#bookName = str(book['name'])
				listOfBooksForUser.append(bookName)

    				if bookName in listOfBookName:
    					continue
    				print bookName
    				listOfBookName.append(bookName)
    				descr = ''
				categories = [0] * 16 #keeping 16 categories
    				if 'description' in book:
					
    					descr = book['description']
                        		# print "DECRIPTION: ", descr
	    				bookDescription = descr.encode('utf-8')
	    				bookDescription = unicodedata.normalize('NFKD', book['description']).encode('utf-8')
					if(len(bookDescription)>0):
						cat=[] #UNIQUE TO A DESCRIPTION PER PERSON
						description=(bookDescription.lower())
						newd=""
						for chars in description:
							if chars in string.punctuation:
								chars=" "
							newd=newd+chars
						newd=newd.split()
						newd=filter(None,newd)
						desp=set(newd)
						#desp=description.strip("\n")
						#print description
						for words in stopwords:
							words=words.strip().lower()
							if(words in desp and di[words] not in cat): #check 1
								#print "Word and corresp cat",words," ",di[words]
								cat.append(di[words])
						#print "Categories for this descrp: ", cat
						#print cat_index
						for iteration in range(0,len(cat)):
							name_book=cat[iteration]
							#print "Cats: ",name_book
							index=cat_index[name_book]
							categories[index]=1		
    				BookRow = (bookName,'', categories[0],categories[1],categories[2],categories[3],categories[4],categories[5],categories[6],categories[7],categories[8],categories[9],categories[10],categories[11],categories[12],categories[13],
categories[14],categories[15] )

    				writeBook.writerow(BookRow)
    	UserRow = (userId, userName, userGender, listOfBooksForUser)
    	writeUser.writerow(UserRow)

for val in listOfIds:
	writeUserID.writerow([val])

for val2 in listOfBookName:
    writeBookID.writerow([val2])
