# BookMart
A Facebook Profile-Based Gift Book Recommender System
<ol type="1">
<li>Collaborative Algorithms</li>
  <p> Item-based Collaborative Filtering - If two items tend to have the same users like and dislike them, then they are similar and users are expected to have similar preferences for similar items. Item based similarity is deduced from user preferences rather than item metadata.</p>
<li>Content Based Filtering</li>
  <p>Algorithms that attempt to recommend items that are similar to items the user liked in the past. They treat the recommendation problem as a search for related items. Items selected for recommendation are items whose content correlates the most with the user's preferences. Content based algorithms analyze item descriptions to identify items that are of particular interest.</p>
<li>Hybrid</li>
<p>For Hybrid algorithms, we thought of two main approaches overcoming shortcomings of both Collaborative and Content based Algorithms like- early rater problem, sparsity issue and opinions of users don’t consistently match always.</p>
  <ol type="a">
    <li>Collaborative Filtering and adding weightage to common categories of two books(Hybrid 1) - While calculating similarity of two books, we gave equal weightage to jaccard similarity score and number of common categories between two books.</li>
  <li>Content based filtering and collaborative filtering (Hybrid 2)- Gave equal weightage to similarity score of book and user and score calculated for a book to a user using collaborative filtering. Main idea behind hybridising the approaches was to overcome the shortcomings of both the approaches and trying to achieve better recommendation by combining the results achieved by both.</li>
  </ol>
 </ol>
