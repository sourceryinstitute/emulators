!
!     (c) 2019-2020 Guide Star Engineering, LLC
!     This Software was developed for the US Nuclear Regulatory Commission (US NRC) under contract
!     "Multi-Dimensional Physics Implementation into Fuel Analysis under Steady-state and Transients (FAST)",
!     contract # NRC-HQ-60-17-C-0007
!
module intrinsics_m 
  !! summary: Fortran 2003 emulation of a Fortran 2008 intrinsic function: findloc
  !! author: Damian Rouson
  implicit none

  private
#if defined EMULATE_INTRINSICS || defined EMULATE_FINDLOC
  public :: findloc
#endif

  interface
    module subroutine ensure_non_empty_instrinsic_m
    end subroutine
  end interface

#if defined EMULATE_INTRINSICS || defined EMULATE_FINDLOC

  interface findloc

    pure module function findloc_integer_dim1(array, value, dim, back) result(location)
      !! Fortran 2003 emulation of Fortran 2008 intrinsic function findloc
      implicit none
      integer, intent(in) :: array(:), value, dim
      logical, intent(in), optional :: back
      integer location
    end function

    pure module function findloc_logical_dim1(array, value, dim, back) result(location)
      implicit none
      logical, intent(in) :: array(:), value, back
      integer, intent(in) :: dim
      integer location
    end function

    pure module function findloc_character_dim1(array, value, dim, back) result(location)
      implicit none
      character(len=*), intent(in) :: array(:), value
      integer, intent(in) :: dim
      logical, intent(in) :: back
      integer location
    end function

  end interface

#endif /* EMULATE_INTRINSICS || defined EMULATE_FINDLOC */

end module intrinsics_m
