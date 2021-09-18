!
!     (c) 2019-2020 Guide Star Engineering, LLC
!     This Software was developed for the US Nuclear Regulatory Commission (US NRC) under contract
!     "Multi-Dimensional Physics Implementation into Fuel Analysis under Steady-state and Transients (FAST)",
!     contract # NRC-HQ-60-17-C-0007
!
module collectives_m
  !! summary: Fortran 2008 coarray emulations of Fortran 2018 collective subroutines
  !! author: Damian Rouson
  use iso_fortran_env, only : real32, real64

  implicit none

  private
#if defined EMULATE_COLLECTIVES || defined EMULATE_CO_SUM
  public :: co_sum
#endif
#if defined EMULATE_COLLECTIVES || defined EMULATE_CO_BROADCAST
  public :: co_broadcast
#endif
#if defined EMULATE_COLLECTIVES || defined EMULATE_CO_REDUCE
  public :: co_reduce
#endif

  interface
    module subroutine ensure_non_empty_collectives_m
    end subroutine
  end interface

#if defined EMULATE_COLLECTIVES || defined EMULATE_CO_SUM

  interface co_sum

    module subroutine co_sum_integer(a,result_image,stat,errmsg)
      !! parallel computation of the sum of the first argument
      implicit none
      integer, intent(inout) :: a
      integer, intent(in), optional :: result_image
      integer, intent(out), optional ::  stat
      character(len=*), intent(inout), optional :: errmsg
    end subroutine

    module subroutine co_sum_real32_1D_array(a,result_image,stat,errmsg)
      implicit none
      real(real32), intent(inout) :: a(:)
      integer, intent(in), optional :: result_image
      integer, intent(out), optional :: stat
      character(len=*), intent(inout), optional :: errmsg
    end subroutine

    module subroutine co_sum_real32_2D_array(a,result_image,stat,errmsg)
      implicit none
      real(real32), intent(inout) :: a(:,:)
      integer, intent(in), optional :: result_image
      integer, intent(out), optional :: stat
      character(len=*), intent(inout), optional :: errmsg
    end subroutine

    module subroutine co_sum_real64_1D_array(a,result_image,stat,errmsg)
      implicit none
      real(real64), intent(inout) :: a(:)
      integer, intent(in), optional :: result_image
      integer, intent(out), optional :: stat
      character(len=*), intent(inout), optional :: errmsg
    end subroutine

    module subroutine co_sum_real64_2D_array(a,result_image,stat,errmsg)
      implicit none
      real(real64), intent(inout) :: a(:,:)
      integer, intent(in), optional :: result_image
      integer, intent(out), optional :: stat
      character(len=*), intent(inout), optional :: errmsg
    end subroutine

  end interface

#endif /* defined EMULATE_COLLECTIVES || defined EMULATE_CO_SUM */

#if defined EMULATE_COLLECTIVES || defined EMULATE_CO_BROADCAST

  interface co_broadcast

    module subroutine co_broadcast_logical(a,source_image,stat,errmsg)
      !! parallel one-to-all communication of the value of first argument
      implicit none
      logical, intent(inout) :: a
      integer, intent(in) :: source_image
      integer, intent(out), optional ::  stat
      character(len=*), intent(inout), optional :: errmsg
    end subroutine

    module subroutine co_broadcast_integer(a,source_image,stat,errmsg)
      implicit none
      integer, intent(inout) :: a
      integer, intent(in) :: source_image
      integer, intent(out), optional ::  stat
      character(len=*), intent(inout), optional :: errmsg
    end subroutine

    module subroutine co_broadcast_real32_1D_array(a,source_image,stat,errmsg)
      implicit none
      real(real32), intent(inout) :: a(:)
      integer, intent(in) :: source_image
      integer, intent(out), optional ::  stat
      character(len=*), intent(inout), optional :: errmsg
    end subroutine

    module subroutine co_broadcast_real32_2D_array(a,source_image,stat,errmsg)
      implicit none
      real(real32), intent(inout) :: a(:,:)
      integer, intent(in) :: source_image
      integer, intent(out), optional ::  stat
      character(len=*), intent(inout), optional :: errmsg
    end subroutine

    module subroutine co_broadcast_real64_1D_array(a,source_image,stat,errmsg)
      implicit none
      real(real64), intent(inout) :: a(:)
      integer, intent(in) :: source_image
      integer, intent(out), optional ::  stat
      character(len=*), intent(inout), optional :: errmsg
    end subroutine

    module subroutine co_broadcast_real64_2D_array(a,source_image,stat,errmsg)
      implicit none
      real(real64), intent(inout) :: a(:,:)
      integer, intent(in) :: source_image
      integer, intent(out), optional ::  stat
      character(len=*), intent(inout), optional :: errmsg
    end subroutine

  end interface

#endif /* defined EMULATE_COLLECTIVES || defined EMULATE_CO_BROADCAST */

#if defined EMULATE_COLLECTIVES || defined EMULATE_CO_REDUCE

  interface co_reduce

    module subroutine co_reduce_logical(a,operation,result_image,stat,errmsg)
      !! parallel reduction of values across images of the first argument
      implicit none
      abstract interface
        pure function operation_i(x, y)
          logical, intent(in) :: x, y
          logical :: operation_i
        end function
      end interface
      logical, intent(inout) :: a
      procedure(operation_i) :: operation
      integer, intent(in), optional :: result_image
      integer, intent(out), optional :: stat
      character(len=*), intent(inout), optional :: errmsg
    end subroutine

  end interface

#endif /* defined EMULATE_COLLECTIVES || defined EMULATE_CO_REDUCE */

end module collectives_m
