# BookMart
A Facebook Profile-Based Gift Book Recommender System <br><br>
<b>Methodology Used : </b><br>
<p align="center">
<img src="https://github.com/ShwetaSood/BookMart/blob/master/photos/Screen%20Shot%202016-11-23%20at%201.31.04%20PM.png" 
height="500" width="500" align="center"/></p>
<b>Algorithms Used : </b><br>
<ol type="1">
<li>Collaborative Algorithm</li>
  <p> Item-based Collaborative Filtering - If two items tend to have the same users like and dislike them, then they are similar and users are expected to have similar preferences for similar items. Item based similarity is deduced from user preferences rather than item metadata.</p>
<li>Content Based Filtering</li>
  <p>Algorithms that attempt to recommend items that are similar to items the user liked in the past. They treat the recommendation problem as a search for related items. Items selected for recommendation are items whose content correlates the most with the user's preferences. Content based algorithms analyze item descriptions to identify items that are of particular interest.</p>
<li>Hybrid</li>
<p>For Hybrid algorithms, we thought of two main approaches overcoming shortcomings of both Collaborative and Content based Algorithms like- early rater problem, sparsity issue and opinions of users don’t consistently match always.</p>
  <ol type="a">
    <li>Collaborative Filtering and adding weightage to common categories of two books (Hybrid 1) - While calculating similarity of two books, we gave equal weightage to jaccard similarity score and number of common categories between two books.</li>
  <li>Content based filtering and collaborative filtering (Hybrid 2)- Gave equal weightage to similarity score of book and user and score calculated for a book to a user using collaborative filtering. Main idea behind hybridising the approaches was to overcome the shortcomings of both the approaches and trying to achieve better recommendation by combining the results achieved by both.</li>
  </ol>
 <li> Did the same exercise by segregating the data based on male and female, such that a male user gets book recommended by observing the data of other male users and same for female.
 </ol>
 Similarity measures used:
<p align="center">
<ol type="1">
<li>Content based Filtering - Cosine Similarity</li>
 <img src="https://github.com/ShwetaSood/BookMart/blob/master/photos/Screen%20Shot%202016-11-23%20at%201.29.25%20PM.png" width="650" height="80"/><br>
 <li>Item-Item based Collaborative Filtering - Jaccard Similarity</li>
  <img src="https://github.com/ShwetaSood/BookMart/blob/master/photos/Screen%20Shot%202016-11-23%20at%201.29.34%20PM.png" width="550" height="80"/>
 </ol> 
</p>
 Results Obtained
<p>
In the case of Facebook profile data, ratings are unary: either a user likes an item (thereby making a positive association), or not. The absence of a ‘like’ can be interpreted either as a dislike or ignorance about the item. We therefore chose to use the Precision, because the unary rating scale makes the task of recommending books more like a classification problem. We define Precision as follows, where ri denotes a book recommended to the user and L denotes the set of books liked by the user.
We have used Precision to calculate the final results.</p>
<p align="center">
 <img src="https://github.com/ShwetaSood/BookMart/blob/master/photos/Screen%20Shot%202016-11-23%20at%201.29.46%20PM.png" height="150"/><br>
Precision of various algorithms used:<br>
<img src="https://github.com/ShwetaSood/BookMart/blob/master/photos/Screen%20Shot%202016-11-23%20at%201.50.12%20PM.png" width="450"/>
</p>

