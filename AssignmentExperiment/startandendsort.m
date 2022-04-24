function v=startandendsort(v)
    for i = 1:length(v)
        if v(1,i) == 1
            v([1 i]) = v([i 1]);
        end
        if v(1,i) == length(v)
            v([i length(v)]) = v([length(v) i]);
        end
    end
end