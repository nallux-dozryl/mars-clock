:-  %say
|=  [* [date=@da ~] ~]
:-  %noun
=<  
:*  d=(sol-days date)
    h=(sol-hours date)
    m=(sol-minutes date)
    s=(sol-seconds date)
    f=~
==
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
  ++  present  :: number of seconds since noon January 1st 2000                                                                        
    |=  date=@da                                                            
    (sub:rq (seconds date) (seconds ~2000.1.1..12.00.00))
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
  ++  sol-days 
    |=  date=@da
    (div (abs:si (tail (toi:rq (msd date)))) day:yo)
  ++  sol-hours
    |=  date=@da
    =/  days  (mul day:yo (sol-days date))
    =/  int   (abs:si (tail (toi:rq (msd date))))
    (div (sub int days) hor:yo)
  ++  sol-minutes
    |=  date=@da
    =/  days    (mul day:yo (sol-days date))
    =/  hours   (mul hor:yo (sol-hours date))
    =/  int     (abs:si (tail (toi:rq (msd date))))
    (div (sub (sub (add 60 int) days) hours) mit:yo) :: it's still not accurate and adding 60 seconds fixes it for now
  ++  sol-seconds
    |=  date=@da
    =/  int     (abs:si (tail (toi:rq (msd date))))
    (mod (add 7 int) 60)  :: again, added 7 to make it accurate
--
