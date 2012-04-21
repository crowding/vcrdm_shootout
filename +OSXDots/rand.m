function varargout = rand(varargin)
%A stub for Psychtoolbox.Screen.

import OSXDots.*;
import Psychtoolbox.*;

ans = 'a';
[varargout{1:nargout}] = recordCall(1, 'rand', varargin{:});
if ~isequalwithequalnans(ans, 'a')
    varargout{1} = ans;
end

end