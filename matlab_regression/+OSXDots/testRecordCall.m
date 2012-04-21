function this = testRecordCall(varargin)

    persistent init__;
    this = inherit(TestCase(), autoobject(varargin{:}));
    
    function testEmpty()
        recordCall('reset');
        result = recordCall('readout');
        
        assertEquals(struct('call', cell(1,0), 'arg', cell(1,0), 'nargout', cell(1,0), 'result', cell(1,0), 'error', cell(1,0)), result);
    end

    function testOneCall()
        recordCall('reset');
        recordCall(0, @noop, 123);
        result = recordCall('readout');
        assertEquals(result, struct('call', {@noop}, 'arg', {{123}}, 'nargout', 0, 'result', {{}}, 'error', {[]}));
    end

    function testPassesAlongResult()
        recordCall('reset')
        result1 = recordcall(1, @fliplr, [1 2]);
        assertEquals(result1, [2 1]);
    end

    function testRecordsResult()
        recordCall('reset')
        [~] = recordcall(1, @fliplr, [1 2]);
        result2 = recordCall('readout');
        goal = struct('call', {@fliplr}, 'arg', {{[1 2]}}, 'nargout', {1}, 'result', {{[2 1]}}, 'error', {[]});
        assertEquals(goal, result2);
    end

    function testPassesAlongAndRecordsResultEvenIfNotAskedFor()
        recordCall('reset');
        ans = 'foo';
        recordCall(1, @fliplr, [1 2]);
        assertEquals(ans, [2 1]);
        result2 = recordCall('readout');
        assertEquals(result2, struct('call', {@fliplr}, 'arg', {{[1 2]}}, 'nargout', {0}, 'result', {{[2 1]}}, 'error', {[]}));
    end

    function testPassesAlongError()
        recordCall('reset')
        try
            recordCall(1, @makeError);
            assert(false, 'didn''t make an error!');
        catch e
            assertEquals(e.message, 'an error');
            assertEquals(e.identifier, 'testRecordCall:error');
        end
    end

    function testPassesAlongStringToBuiltin() 
        recordCall('reset')
        recordCall(1, 'cat', 1, 2, 3);
        result = recordCall('readout');
        assertEquals(result, struct('call', {'cat'}, 'arg', {{1,2,3}}, 'nargout', {0}, 'result', {{[2;3]}}, 'error', {[]}));
    end
    
    function makeError()
        error('testRecordCall:error', 'an error');
    end

    function testRecordsError()
        recordCall('reset')
        try
            recordCall(1, @makeError);
            assert(0, 'didn''t make an error!');
        catch
        end
        result = recordCall('readout');
        assertEquals(result(1).error.message, 'an error');
        assertEquals(result(1).error.identifier, 'testRecordCall:error');
    end

    function testRecordsInOrder()
        recordCall('reset');
        recordCall(1, @fliplr, [2 1]);
        recordCall(1, @fliplr, [3 2]);
        r = recordCall('readout');
        
    end

end