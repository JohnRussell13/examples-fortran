program readText
implicit none

integer :: fid = 1
character*256 :: ctmp

!! Max line size 256
character*256, allocatable :: inMatrix(:)
integer :: i, j,  ierr = 0, numLines = 0
logical :: loopFlag

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
do i = 1,size(inMatrix,1)
  loopFlag = .false.
  do j = 1,numLines
    ! Handle first line
    if (i == 1) then
      ! Handle WALL
      if (inMatrix(i)(j:j) == "X") then
        exit
      else
        inMatrix(i)(j:j) = "Y"
      end if
    else
      ! Handle end of the line
      if (j == size(inMatrix,1) .and. inMatrix(i)(j:j) == "X") then
        exit
      end if

      ! Handle WALL
      if (inMatrix(i)(j:j) == "X") then
        loopFlag = .true.
        ! Handle continuing WALL
        if (inMatrix(i)(j+1:j+1) == "X") then
          cycle
        else
          ! Handle valid place
          if (inMatrix(i-1)(j+1:j+1) == "Y") then
            inMatrix(i)(j:j) = "Y"
            loopFlag = .false.
          else
            ! inMatrix(i)(j) = "N"
            cycle
          end if
        end if
      else
        ! Handle valid place
        if (.not. loopFlag) then
          inMatrix(i)(j:j) = "Y"
        else
          ! inMatrix(i)(j) = "N"
        end if
      end if
    end if
  end do
end do

! Print result
do i = 1,size(inMatrix,1)
  write(*,*) trim(inMatrix(i))
end do

! Finish program
deallocate(inMatrix)
close(fid)

end program readText
