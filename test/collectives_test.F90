module collectives_test
    use Vegetables, only: Result_t, Test_Item_t, describe, it, assert_equals, assert_that, assert_not
#if defined EMULATE_COLLECTIVES || defined EMULATE_CO_SUM
    use collectives_m, only : co_sum
#endif
#if defined EMULATE_COLLECTIVES || defined EMULATE_CO_BROADCAST
    use collectives_m, only : co_broadcast
#endif
#if defined EMULATE_COLLECTIVES || defined EMULATE_CO_REDUCE
    use collectives_m, only : co_reduce
#endif

    implicit none
    private

#if defined EMULATE_COLLECTIVES || defined EMULATE_CO_SUM
    public :: test_co_sum
#endif
#if defined EMULATE_COLLECTIVES || defined EMULATE_CO_BROADCAST
    !public :: test_co_broadcast
#endif
#if defined EMULATE_COLLECTIVES || defined EMULATE_CO_REDUCE
    !public :: test_co_reduce
#endif

contains

    module subroutine ensure_non_empty_collectives_test
    end subroutine

#if defined EMULATE_COLLECTIVES || defined EMULATE_CO_SUM

    function test_co_sum() result(tests)
        type(Test_Item_t) :: tests

        tests = describe( &
                "co_sum", &
                [it( &
                        "gives sums with result_image present", &
                        check_co_sum_with_result_image), &
                 it( &
                        "gives sums without result_image present", &
                        check_co_sum_without_result_image)])
    end function

    function check_co_sum_with_result_image() result(result_)
        type(Result_t) :: result_

        integer i, j
        integer, parameter :: result_image=2

        associate(me => this_image())
          i = me
          call co_sum(i, result_image)
          if (me==result_image) then
            result_ = assert_equals(sum([(j, j=1, num_images())]), i, "collective sum on result_image")
          else
            result_ = assert_equals(me, i, "co_sum argument unchanged on non-result_image")
          end if
        end associate
    end function

    function check_co_sum_without_result_image() result(result_)
        type(Result_t) :: result_

        integer i, j

        associate(me => this_image())
          i = me
          call co_sum(i)
          result_ = assert_equals(sum([(j, j=1, num_images())]), i, "co_sum without result_image present")
        end associate
    end function

#endif /* defined EMULATE_COLLECTIVES || defined EMULATE_CO_SUM */

end module
