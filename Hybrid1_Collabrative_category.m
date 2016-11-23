%making new similarity index between two books
%adding new similarity(book1, book2) = 1/2(user based similarity)+ 1/2(category wise books similarity)

load('BooksToUsers.mat', 'booksToUser');
load ('similarityBooks.mat', 'similarity');

[booknum,booktxt,bookraw]=xlsread('./booksInfo.csv');

hybrid_similarity= eye(301); %store similarity between books in the matrix
%constructs diagnol matrix with element 1
count=1;
category = booknum(1:301, 3:18);

for i=1: 301
    for j=1:301
        if(i~=j)
            common_category = category(i,:) & category(j,:);
            sum_categoriesCommon = sum(common_category);
            hybrid_similarity(i,j) = 0.5*similarity(i,j)+ 0.5*sum_categoriesCommon/16;
        end
        
    end
end

save ('hybrid_similarity_score.mat', 'hybrid_similarity');
