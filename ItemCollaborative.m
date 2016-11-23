%read from csv file
%Uses Jaccard Similarity (Item-based Collaborative Filtering)

[usernum,usertxt,userraw]=xlsread('UserInfo.csv'); %
[booknum,booktxt,bookraw]=xlsread('booksInfo.csv');


users = (userraw(2:150,1));
books = userraw(2:150,4);

booksName= bookraw(2:302,1);

booksToUser = cell(301, 150);
booksToUser(:,1) = booksName;
numberOfBooks= size(booksName,1);


for i=2:size(usertxt,1)
    str=cell2mat(usertxt(i,4));
    str=strrep(str,'[','');
    str=strrep(str,']','');
    str=strrep(str,', ',',');
    str=strrep(str,'''','');
%     fprintf('str is :%s', str);
    booksPerUser=strsplit(str,',');
%     display(booksPerUser);
    sizeOfBooksPerUser= size(booksPerUser,2);
    for book= 1:sizeOfBooksPerUser
        flag=0;
        nameOfBook  = cell2mat(booksPerUser(book));
        
%         nameOfBook = a(2);
        for j= 1: numberOfBooks
            if strcmp(nameOfBook, cell2mat(booksToUser(j,1)))==1
                booksToUser(j,i)={[1]};
                flag=1;
                continue;
            end
        end 
        if(flag==0)
            fprintf('Book not found User ID: %d , %s\n',i , nameOfBook );
        end
        
    end
    
end

booksToUser(194,1) = {['1984']}; %manually adding 1984
%finding the similarity between the books
booksToUser(194,29)={[1]};
booksToUser(194,32)={[1]};
booksToUser(194,38)={[1]};
booksToUser(194,43)={[1]};
booksToUser(194,60)={[1]};
booksToUser(194,83)={[1]};
booksToUser(194,131)={[1]};

save ('BooksToUsers.mat', 'booksToUser');

load('BooksToUsers.mat', 'booksToUser');

similarity = eye(301); %store similarity between books in the matrix
%constructs diagnal matrix with element 1
count=1;

for i= 1:300
    for j=i+1:301
        commonUsers=0;
        totalUsers=0;
        for usersNumber= 2:150
            sameUser=0;
            book1 = isequaln(booksToUser(i,usersNumber), {1})==1;
            book2 = isequaln(booksToUser(j,usersNumber), {1})==1;
            if book1 && book2
                commonUsers= commonUsers+1;
            end
            if book1
                totalUsers= totalUsers+1;
            end
            if book2
                totalUsers= totalUsers+1;
            end            
        end
        
        if totalUsers==0
            similarity(i,j)= 0;            
        else
            similarity(i,j)= commonUsers/ totalUsers;                      
        end
        similarity(j,i)= similarity(i,j);
    
    end    
end

save ('similarityBooks.mat', 'similarity');
