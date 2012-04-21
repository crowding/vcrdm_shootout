function varargout = Screen(varargin)
%A stub for Psychtoolbox.Screen.
import OSXDots.*;
import Psychtoolbox.*;

ans = 'a';
[varargout{1:nargout}] = recordCall(1, @Psychtoolbox.Screen, varargin{:});
if ~isequalwithequalnans(ans, 'a')
    varargout{1} = ans;
end

end