:-  %say
|=  [* [date=@da ~] ~]
:-  %noun
=<  (days date)
|%
  ++  seconds  ::  converts date into `@rq`seconds                             
    |=  date=@da                                                                   
    =/  yel        (yell date)
    =/  subsecond  ?:  =(f.yel ~)  
                   .~~~0
                   (div:rq (sun:rq (head f.yel)) (sun:rq 0xffff))
    =/  second     (sun:rq s.yel)
    =/  minute     (sun:rq (mul mit:yo m.yel))
    =/  hour       (sun:rq (mul hor:yo h.yel))
    =/  dey        (sun:rq (mul day:yo d.yel))
    :(add:rq dey hour minute second subsecond)
  ++  present  :: number of seconds since midnight January 1st 2000                                                                        
    |=  date=@da                                                            
    (sub:rq (seconds date) (seconds ~2000.1.1))
  ++  sync
    |=  date=@da
    =/  dey        (sun:rq (mul day:yo 4))
    =/  hour       (sun:rq (mul hor:yo 12))
    =/  lag        (add:rq dey hour)
    (div:rq (sub:rq (present date) lag) .~~~1.02749125)
  ++  msd
    |=  date=@da
    =/  gregorian  (sun:rq (mul 44.796 day:yo))
    =/  mars24     (mul:rq (sun:rq day:yo) .~~~0.00096)
    (sub:rq (add:rq (sync date) gregorian) mars24)
  ++  days
    |=  date=@da
    (div:rq (msd date) (sun:rq day:yo))   
--

