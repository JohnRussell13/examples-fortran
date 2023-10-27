program readText
implicit none

integer :: fid = 1
character*256 :: ctmp

! 1. Assuming that no line of text.txt contains more than 256 characters
character*256, allocatable :: inMatrix(:)
integer :: i = 0, ierr = 0, numLines = 0

open(unit=fid,file='text.txt')

! 2. Get number of lines
do while (ierr == 0)
  numLines = numLines + 1
  read(fid,*,iostat=ierr) CTMP
end do
numLines = numLines - 1

allocate(inMatrix(numLines))

! 4. Read the file content
rewind(fid)
do I = 1, numLines
  read(fid,'(A)') inMatrix(i)
end do

do I = 1,size(inMatrix,1)
  
end do

deallocate(inMatrix)
close(fid)

end program readText
