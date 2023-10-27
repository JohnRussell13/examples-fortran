program hello
      implicit none

      integer :: i
      real :: first(10)
      integer :: second(-2:2)
      integer, allocatable :: third(:,:)

      first = [(i, i = 1, 10)]
      first(1:10:2) = 0
      print *, first
      
      second = [(i, i = -2, 2)]
      print *, second(-1)

      ! Dynamic allocation
      allocate(third(3, 5))
      
      third(1,:) = [(i, i = 1, 5)]
      third(2,:) = [(i, i = 1, 5)]
      third(3,:) = [(i, i = 1, 5)]
      third(:,2) = 0

      print *, third
      deallocate(third)
end program hello
