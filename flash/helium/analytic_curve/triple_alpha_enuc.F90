      program triple_alpha_enuc

! A short program, excised from FLASH, to calculate the triple-alpha
!  nuclear generation rate. 
!    - RTF 012321

      implicit none

      real*8 den, ratraw, rtabe, rbeac, q, conv, avo, ev2erg, Y
      real*8 btemp, tt9, t9, r2abe, t9i32, t9i, t9i23, t9i13, t92, t943
      real*8 t953, t912, t913, oneth, fivsix, t923, t93, t932, t972
      real*8 t985, t9r, t9ri, t9i12, t9r32, enuc
      parameter        (oneth  = 1.0e0/3.0e0, fivsix = 5.0e0/6.0e0)
      parameter  (avo  = 6.0221367e23,  ev2erg = 1.602e-12)
      parameter         (conv = ev2erg*1.0e6*avo)

      btemp = 1.e9
      den   = 1.e5
      Y     = 1.   ! He4 abundance

  !..limit t9 to 10, except for the reverse ratios
      tt9   = btemp * 1.0e-9
      t9r   = tt9
      t9    = min(tt9,10.0e0)
      t912  = sqrt(t9)
      t913  = t9**oneth
      t923  = t913*t913
      t943  = t9*t913
      t953  = t9*t923
      t932  = t9*t912
      t985  = t9**1.6
      t92   = t9*t9
      t93   = t9*t92
      t972  = t912*t93
      t9r32 = t9r*sqrt(t9r)
      t9i   = 1.0e0/t9
      t9i13 = 1.0e0/t913
      t9i23 = 1.0e0/t923
      t9i32 = 1.0e0/t932
      t9i12 = 1.0e0/t912
      t9ri  = 1.0e0/t9r


  !..triple alpha to c12 (has been divided by six)
  !..rate revised according to caughlan and fowler (nomoto ref.) 1988 q = -0.092 
      r2abe = (7.40e+05 * t9i32)* exp(-1.0663*t9i) +                    &
       &        4.164e+09 * t9i23 * exp(-13.49*t9i13 - t92/0.009604) *    &
       &        (1.0e0 + 0.031*t913 + 8.009*t923 + 1.732*t9 +             &
       &        49.883*t943 + 27.426*t953)
  !..q = 7.367
      rbeac = (130.*t9i32) * exp(-3.3364*t9i) +                         &
       &        2.510e+07 * t9i23 * exp(-23.57*t9i13 - t92/0.055225) *    &
       &        (1.0e0 + 0.018*t913 + 5.249*t923 + 0.650*t9 +             &
       &         19.176*t943 + 6.034*t953)
      q = 7.275
      if (t9.gt.0.08) then
       ratraw = 2.90e-16 * (r2abe*rbeac) +                      &
          &                  0.1 * 1.35e-07 * t9i32 * exp(-24.811*t9i)
      else
       ratraw = 2.90e-16*(r2abe*rbeac) *                        &
          &         (0.01 + 0.2*(1.0e0 + 4.0e0*exp(-(0.025*t9i)**3.263)) /   &
          &         (1.0e0 + 4.0e0*exp(-(t9/0.025)**9.227))) +               &
          &         0.1 * 1.35e-07 * t9i32 * exp(-24.811*t9i)
      end if
      ratraw  = ratraw * (den*den) * q

      print *, 'ratraw = ', ratraw

      enuc = ratraw * conv * q * Y**3.
      print *, 'enuc = ', enuc

      end
