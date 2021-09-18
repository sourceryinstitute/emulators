!
!     (c) 2019-2020 Guide Star Engineering, LLC
!     This Software was developed for the US Nuclear Regulatory Commission (US NRC) under contract
!     "Multi-Dimensional Physics Implementation into Fuel Analysis under Steady-state and Transients (FAST)",
!     contract # NRC-HQ-60-17-C-0007
!
submodule(intrinsics_m) intrinsics_s
  use assert_m, only : assert
  implicit none

contains

    module procedure ensure_non_empty_instrinsic_m
    end procedure

#if defined EMULATE_INTRINSICS || defined EMULATE_FINDLOC

  module procedure findloc_integer_dim1

    if ( .not. present(back)) then

      location = minloc(array, dim, array == value)

    else if (back .eqv. .false.) then

      location = minloc(array, dim, array == value)

    else ! back is present and .true. so work around GCC 8 lack of support for the "back" argument
      block
        integer, parameter :: loop_increment=-1, base_index=1
        integer index_

        call assert(dim==1,"findloc_integer_dim1: unsupported use case")

        associate( lower_bound=>lbound(array,dim) )
          do index_=ubound(array,dim), lower_bound, loop_increment
            if (array(index_)==value) then
              location = index_ - lower_bound + base_index
              return
            end if
          end do
        end associate
        location=0
      end block
    end if

  end procedure

  module procedure findloc_logical_dim1
    integer, parameter :: loop_increment=-1, base_index=1
    integer index_

    call assert(back .and. dim==1,"findloc_logical_dim1_backtrue: unsupported use case")

    associate( lower_bound=>lbound(array,dim) )
      do index_=ubound(array,dim), lower_bound, loop_increment
        if (array(index_) .eqv. value) then
          location = index_ - lower_bound + base_index
          return
        end if
      end do
    end associate
    location=0

  end procedure

  module procedure findloc_character_dim1
    integer, parameter :: base_index=1
    integer index_, loop_increment, start, finish

    call assert(dim==1,"findloc_character_dim1: unsupported use case")

    associate( lower_bound=>lbound(array,dim) )
      select case(back)
        case(.true.)
          start = ubound(array,dim)
          finish = lower_bound
          loop_increment=-1
        case(.false.)
          start = lower_bound
          finish = ubound(array,dim)
          loop_increment=1
      end select

      do index_=start, finish, loop_increment
        if (array(index_)==value) then
          location = index_ - lower_bound + base_index
          return
        end if
      end do
    end associate
    location=0

  end procedure

#endif /* EMULATE_INTRINSICS || defined EMULATE_FINDLOC */

end submodule intrinsics_s
