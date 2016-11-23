%read from csv file

[num,txt,raw] = xlsread('UserInfo.csv');


[usernum,usertxt,userraw]=xlsread('UserInfo.csv'); %
[booknum,booktxt,bookraw]=xlsread('booksInfo.csv');
for i=2:size(usertxt,1)
    usertxt(i,1)={usernum(i-1,1)};
    str=cell2mat(usertxt(i,4));
    str=strrep(str,'[','');
    str=strrep(str,']','');
    str=strrep(str,', ',',');
    str=strrep(str,'''','');
   
    arr=strsplit(str,',');
end




users = (userraw(2:150,1));
books = userraw(2:150,4);

booksName= bookraw(2:303,1);

booksToUser = cell(302, 150);
booksToUser(:,1) = booksName;
numberOfBooks= size(booksName,1);
for userId = 1:149
    booksPerUser = strsplit(cell2mat(books(userId)), ',');
    sizeOfBooksPerUser= size(booksPerUser,2);
    for book= 1:sizeOfBooksPerUser
        flag=0;
        a  = regexp(cell2mat(booksPerUser(book)),'''','split');
        nameOfBook = a(2);
        for j= 1: numberOfBooks
            if isequaln(nameOfBook, booksToUser(j,1))==1
                booksToUser(j,userId+1)=1;
                flag=1;
                continue;
            end
        end 
        if(flag==0)
            fprintf('Book not found %s',nameOfBook );
        end
        
    end
end