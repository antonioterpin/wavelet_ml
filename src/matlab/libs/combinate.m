function combinate(f, N, bitmask, i)
%COMBINATE Perform f on all combinations of N elements, given through
%bitmask
%   combinate(f, N); bitmask, i are used on recursion

    if nargin == 2
        % First call
        combinate(f, N, 0, 1);
    else
        assert(nargin == 4, "Wrong number of parameters. Use combinate(f, N);");
        if i == N
            f(bitmask);
            f(bitset(bitmask, i));
        else if i < N
            combinate(f, N, bitmask, i + 1);

            % set i-th bit
            bitmask = bitset(bitmask, i);
            combinate(f, N, bitmask, i + 1);
        end
    end 
    
end

