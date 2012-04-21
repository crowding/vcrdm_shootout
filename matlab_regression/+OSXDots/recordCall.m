function varargout = recordCall(passalong, f, varargin)

persistent calls;
persistent ncalls;
persistent uniqueValue;
if isempty(ncalls)
    calls = {};
    ncalls = 0;
    uniqueValue = tempname;
end

switch(passalong)
    case 'reset'
        calls = {};
        ncalls = 0;        
    case 'readout'
        s = struct('call', cell(1, ncalls), 'arg', cell(1, ncalls), 'nargout', cell(1, ncalls), 'result', cell(1, ncalls), 'error', cell(1, ncalls));
        walkback = calls;
        for i = ncalls:-1:1
            s(i) = walkback{1};
            walkback = walkback{2};
        end
        varargout{1} = s;
    otherwise
        ncalls = ncalls + 1;
        if passalong
            ans = uniqueValue;
            try
                if isa(f, 'char')
                    [varargout{1:nargout}] = builtin(f, varargin{:});
                else
                    [varargout{1:nargout}] = f(varargin{:});
                end
                if ~isequalwithequalnans(ans, uniqueValue)
                    varargout{1} = ans;
                end
                calls = {struct('call', f, 'arg', {varargin}, 'nargout', nargout, 'result', {varargout}, 'error', []) calls};
            catch err
                calls = {struct('call', f, 'arg', {varargin}, 'nargout', nargout, 'result', {{}}, 'error', err) calls};
                rethrow(err);
            end
        else
            calls = {struct('call', f, 'arg', {varargin}, 'nargout', nargout, 'result', {{}}, 'error', []) calls};
        end
end

    %do you know how to properly stub a function such that it actually works?
    %It's fucking tricky.
    
    %The first thing to realize is, a function call doesn't just have
    %arguments. It has arguments and a _requested number of outputs._
    
    %But that's not the whole story. Try calling a function from the
    %command line
    %You see, you _think_ that there's just nargin and argout, and you 're
    %set. Have you ever figured out what controls whether a function
    %produces an output printed to the terminal or not? Or whether a
    %function's output gets assigned to ans, or 
    
    %Then there's the whole matter of replicating "nargout" the function.
    %Sometimes something calls nargout introspectively, to determine now
    %many outputs a function has. Only way to stub that out is manually for
    %each function, or horribly.

    
        
end