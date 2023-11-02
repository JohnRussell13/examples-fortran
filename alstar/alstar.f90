module MatrixModule
implicit none

public :: matrixSize
public :: matrixReader
contains

  function matrixSize() result(numLines)
    implicit none

    integer :: numLines
    integer :: fid = 1
    character*256 :: ctmp

    integer :: ierr = 0

    open(unit=fid,file='text.txt')

    ! Get number of lines in input
    numLines = 0
    do while (ierr == 0)
      numLines = numLines + 1
      read(fid,*,iostat=ierr) ctmp
    end do
    numLines = numLines - 1
    
    close(fid)
  end function matrixSize

  function matrixReader(numLines) result(inMatrix)
    implicit none

    integer :: numLines
    !! Max line size 256
    character*256, allocatable :: inMatrix(:)

    integer :: fid = 1
    integer :: i

    open(unit=fid,file='text.txt')

    ! Read input
    allocate(inMatrix(numLines))
    ! rewind(fid)
    do i = 1, numLines
      read(fid,'(A)') inMatrix(i)
    end do

    close(fid)
  end function matrixReader
end module MatrixModule

program readText
use MatrixModule
implicit none

character*256, allocatable :: inMatrix(:)
integer :: i, j, k, ierr = 0, matrixHeight, matrixWidth
logical :: loopFlag

matrixHeight = matrixSize()
inMatrix = matrixReader(matrixHeight)

matrixHeight = 12
matrixWidth = len(trim(inMatrix(1)))
k = 1
! MAIN PROGRAM
do i = 1, matrixHeight
  loopFlag = .false.
  do j = k, matrixWidth
    ! Handle first line
    if (i == 1) then
      ! Handle WALL
      if (inMatrix(i)(j:j) == "1") then
        exit
      ! Handle before WALL
      else
        inMatrix(i)(j:j) = "Y"
        cycle
      end if
    end if

    ! Handle start of the line
    if (j == k .and. inMatrix(i)(j:j) == "1") then
      k = k + 1
      cycle
    end if

    ! Handle end of the line
    if (j == matrixWidth .and. inMatrix(i)(j:j) == "1") then
      exit
    end if

    ! Handle WALL
    if (inMatrix(i)(j:j) == "1") then
      loopFlag = .true.
      ! Handle continuing WALL
      if (inMatrix(i)(j+1:j+1) == "1") then
        cycle
      ! Handle valid next place
      else if (inMatrix(i-1)(j+1:j+1) == "Y") then
        loopFlag = .false.
      end if
      cycle
    end if

    ! Handle valid place
    if (.not. loopFlag) then
      inMatrix(i)(j:j) = "Y"
    ! Handle invalid place, but valid next place
    else if (inMatrix(i-1)(j+1:j+1) == "Y") then
      loopFlag = .false.
    end if
  end do
end do

! Print result
do i = 1,size(inMatrix,1)
  write(*,"(a)") trim(inMatrix(i))
end do

! Finish program
deallocate(inMatrix)
end program readText

