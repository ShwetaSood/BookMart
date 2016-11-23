%Generating Hybrid
%Gave equal weightage to similarity score of book and user and score calculated for a book to a user 
%using collaborative filtering. Main idea behind hybridising the approaches was to overcome the shortcomings
% of both the approaches and trying to achieve better recommendation by combining the results achieved by both.

clc;
clear all;
load('scoreOfBooks.mat');
load('cosine.mat');
load('usertxt.mat');

temp_arr(1,:)=similarity_matrix(1,2:size(similarity_matrix,2));
recom_matrix=cell(size(similarity_matrix,1),3);
recom_matrix(1,1)={'User Name'};
recom_matrix(1,2)={'Recommended Book 1'};
recom_matrix(1,3)={'Recommended Book 2'};
recom_matrix(1,4)={'Recommended Book 3'};
recom_matrix(2:size(recom_matrix,1),1)=similarity_matrix(2:size(similarity_matrix,1),1);
scoreOfBooks=transpose(scoreOfBooks);

final_similarity_matrix=cell(size(similarity_matrix,1),size(similarity_matrix,2));
final_similarity_matrix(2:size(final_similarity_matrix,1),1)=similarity_matrix(2:size(similarity_matrix,1),1);
final_similarity_matrix(1,2:size(final_similarity_matrix,2))=similarity_matrix(1,2:size(similarity_matrix,2));

for i=2:size(similarity_matrix,1)
    for j=2:size(similarity_matrix,2)
        final_similarity_matrix(i,j)={(0.5*cell2mat(similarity_matrix(i,j)))+(0.5*scoreOfBooks(i-1,j-1))};
    end
end

for i=2:size(final_similarity_matrix,1)
    temp_arr(1,:)=final_similarity_matrix(1,2:size(final_similarity_matrix,2));
    temp_arr(2,:)=final_similarity_matrix(i,2:size(final_similarity_matrix,2));
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
