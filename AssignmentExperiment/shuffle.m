function v=shuffle(v)  %shuffles data between start and finish node and creates a random gene   
    v=v(randperm(length(v)));
    v=startandendsort(v);
 end