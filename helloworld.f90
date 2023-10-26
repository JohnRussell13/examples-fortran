program hello
      implicit none

      real :: height
      character :: initial
      complex :: point
      logical :: bool
      integer :: age

      height = 1.82
      initial = 'A'
      point = (2, -1)
      bool = .true.
      age = 90

      print *, 'Hey ', initial, ', I see it is', bool, 'that you are', height, 'm tall'
      print *, 'Are you really,', age, 'years old? This is a number', point

      print *, (0, 1), '*', (0,1), '=', (0,1) * (0,1)
end program hello
