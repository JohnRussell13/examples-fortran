program readText
implicit none

integer :: fid = 1
character*256 :: ctmp

!! Max line size 256
character*256, allocatable :: inMatrix(:)
integer :: i, j, k, ierr = 0, numLines = 0
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

k = 1
! MAIN PROGRAM
do i = 1,size(inMatrix,1)
  loopFlag = .false.
  do j = k,numLines
    ! Handle first line
    if (i == 1) then
      ! Handle WALL
      if (inMatrix(i)(j:j) == "1") then
        exit
      ! Handle before WALL
      else
        inMatrix(i)(j:j) = "Y"
      end if
    ! Handle regular lines
    else
      ! Handle end of the line
      if (j == size(inMatrix,1) .and. inMatrix(i)(j:j) == "1") then
        exit
      end if

      ! Handle start of the line
      if (j == k .and. inMatrix(i)(j:j) == "1") then
        k = k + 1
        cycle
      end if

      ! Handle WALL
      if (inMatrix(i)(j:j) == "1") then
        loopFlag = .true.
        ! Handle continuing WALL
        if (inMatrix(i)(j+1:j+1) == "1") then
          cycle
        else
          ! Handle valid next place
          if (inMatrix(i-1)(j+1:j+1) == "Y") then
            loopFlag = .false.
          ! Handle invalid next place
          ! else
          !   cycle
          end if
        end if
      ! Handle NO WALL
      else
        ! Handle valid place
        if (.not. loopFlag) then
          inMatrix(i)(j:j) = "Y"
        ! Handle invalid place
        else
          ! Handle valid next place
          if (inMatrix(i-1)(j+1:j+1) == "Y") then
            loopFlag = .false.
          ! Handle invalid next place
          ! else
          !   cycle
          end if
        end if
      end if
    end if
  end do
end do

! Print result
do i = 1,size(inMatrix,1)
  write(*,"(a)") trim(inMatrix(i))
end do

! Finish program
deallocate(inMatrix)
close(fid)

end program readText
