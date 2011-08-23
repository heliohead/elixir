module Function
  module Behavior
    % Dynamically define call and [] as methods that receives
    % up to 20 arguments and forward them to the function.
    20.times [], do (i, acc)
      contents = [
        {
          'clause, __LINE__, acc, [], [
            { 'call, __LINE__, {'var, __LINE__, 'self}, acc }
          ]
        }
      ]

      define_erlang_method __FILE__, __LINE__, '[], acc.length, contents
      define_erlang_method __FILE__, __LINE__, 'call, acc.length, contents
      [{ 'var, __LINE__, '"V#{i}" }|acc]
    end

    def apply(args)
      Erlang.apply(self, args)
    end

    def arity
      { 'arity, value } = Erlang.fun_info(self, 'arity)
      value
    end

    % Creates a function that calls self
    % and passes the result to fun
    %
    % Precondition: both functions must have arity 1
    %
    % Returns the composed function
    %
    % g = f.and_then -> (x) x*x
    %
    def and_then(fun)
      if arity == 1 && fun.arity == 1
        -> (x) fun.(self.(x))
      else
        self.error('bad_arity)
      end
    end
  end
end
