program readText
implicit none

integer :: fid = 1
character*256 :: ctmp

!! Max line size 256
character*256, allocatable :: inMatrix(:)
integer :: i, j,  ierr = 0, numLines = 0

open(unit=fid,file='text.txt')

! Get number of lines in input
do while (ierr == 0)
  numLines = numLines + 1
  read(fid,*,iostat=ierr) CTMP
end do
numLines = numLines - 1

! Read input
allocate(inMatrix(numLines))
rewind(fid)
do i = 1, numLines
  read(fid,'(A)') inMatrix(i)
end do

! MAIN PROGRAM
do i = size(inMatrix,1),1,-1
  do j = 1,numLines,1
    inMatrix(i)(j:j) = "Y"
  end do
end do

! Print result
do i = 1,size(inMatrix,1),1
  write(*,*) trim(inMatrix(i))
end do

! Finish program
deallocate(inMatrix)
close(fid)

end program readText
