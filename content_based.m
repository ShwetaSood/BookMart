%Providing equal weights to all features.

clc;
clear all;

[booknum,booktxt,bookraw]=xlsread('./booksInfo.csv');
for i=2:size(booktxt,1)
    for j=3:18
        booktxt(i,j)={booknum(i-1,j)};
    end
end
booktxt(195,1)={'1984'};

[usernum,usertxt,userraw]=xlsread('./UserInfo.csv');
user_matrix=cell(size(usertxt,1),17);
user_matrix(1,1)={'User Name'};
user_matrix(1,2:size(user_matrix,2))=booktxt(1,3:18);
user_matrix(2:size(user_matrix,1),1)=usertxt(2:size(usertxt,1),2);


book_matrix=cell(size(booktxt,1),size(booktxt,2)-1);
book_matrix(1,1)={'Book Name'};
book_matrix(1,2:size(book_matrix,2))=booktxt(1,3:18);
book_matrix(2:size(book_matrix,1),1)=booktxt(2:size(booktxt,1),1);
book_matrix(2:size(book_matrix,1),2:size(book_matrix,2))=booktxt(2:size(booktxt,1),3:18);

for i=2:size(usertxt,1)
    usertxt(i,1)={usernum(i-1,1)};
    str=cell2mat(usertxt(i,4));
    str=strrep(str,'[','');
    str=strrep(str,']','');
    str=strrep(str,', ',',');
    str=strrep(str,'''','');
    arr=strsplit(str,',');
    cat=zeros(1,16);
    k=1;
    for j=1:length(arr)
        val=ismember(book_matrix(2:size(book_matrix,1),1),cell2mat(arr(j)));
        if(size(find(val==0),1)~=(size(book_matrix,1)-1))
            index=find(ismember(book_matrix(2:size(book_matrix,1),1),cell2mat(arr(j))));
            index_arr(k)=index+1;
            k=k+1;
        else
            disp(['No for ',arr(j),' for user ',i]);
        end
    end
    union_arr=zeros(k-1,16);
    for j=1:k-1
        pos=index_arr(j);
        union_arr(j,:)=double(cell2mat(book_matrix(pos,2:17)));
    end
    for j=1:16
        if(length(find(union_arr(:,j)==0))==size(union_arr,1))
            cat(j)=0;
        else
            cat(j)=1;
        end
    end
    for j=2:17
        user_matrix(i,j)={cat(j-1)};
    end
end

similarity_matrix=cell(size(user_matrix,1),size(book_matrix,1));
similarity_matrix(2:size(similarity_matrix,1),1)=user_matrix(2:size(user_matrix,1),1);
similarity_matrix(1,2:size(similarity_matrix,2))=book_matrix(2:size(book_matrix,1),1);

for i=2:size(user_matrix,1)
    for j=2:size(book_matrix,1)
        dot_val=dot(cell2mat(user_matrix(i,2:size(user_matrix,2))),cell2mat(book_matrix(j,2:size(book_matrix,2))));
        val_user=norm(cell2mat(user_matrix(i,2:size(user_matrix,2))));
        val_book=norm(cell2mat(book_matrix(j,2:size(book_matrix,2))));
        similarity_matrix(i,j)={dot_val/(val_user*val_book)};
    end
end

temp_arr(1,:)=similarity_matrix(1,2:size(similarity_matrix,2));
recom_matrix=cell(size(user_matrix,1),3);
recom_matrix(1,1)={'User Name'};
recom_matrix(1,2)={'Recommended Book 1'};
recom_matrix(1,3)={'Recommended Book 2'};
recom_matrix(1,4)={'Recommended Book 3'};
recom_matrix(2:size(recom_matrix,1),1)=user_matrix(2:size(user_matrix,1),1);

for i=2:size(similarity_matrix,1)
    temp_arr(1,:)=similarity_matrix(1,2:size(similarity_matrix,2));
    temp_arr(2,:)=similarity_matrix(i,2:size(similarity_matrix,2));
    temp_arr=sortrows(temp_arr',-2)'; %Sort by descending order on 2nd row
    k=2;
    for j=1:length(temp_arr)
        str=cell2mat(usertxt(i,4));
        str=strrep(str,'[','');
        str=strrep(str,']','');
        str=strrep(str,', ',',');
        str=strrep(str,'''','');
        arr=strsplit(str,',');
        val=ismember(arr,cell2mat(temp_arr(1,j)));
        if(size(find(val==0),2)==size(arr,2)&& k<=4)
            recom_matrix(i,k)=temp_arr(1,j);
            k=k+1;
        end
        if(k>4)
            break;
        end
    end
end
recom_matrix(:,k)=usertxt(:,4);