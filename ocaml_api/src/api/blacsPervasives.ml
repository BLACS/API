module Make =
  functor (Host : sig val host : string end) ->
  struct          
    let clock_time = Clock.time Host.host
        
    let io_write   = Io.write   Host.host
        
    let io_read    = Io.read    Host.host
        
    let io_hash    = Io.hash    Host.host
  end
