Hope
====

Motivation and Usage
--------------------

Are you hoping for a world with full compiler support for recent Fortran
standards?  Emulating an unsupported feature facilitates using it prior to
compiler support.  This path offers minimal impact on future code. Switching to
the compiler's version of a feature might involve little more than toggling a
preprocessor macro:
```fortran
#ifdef EMULATE_COLLECTIVE_SUBROUTINES
  use hope, only : co_sum, co_broadcast, co_min, co_max, co_reduce
#endif
```
and then passing the macro at build time.  For example, when building
an application with the Fortran Package Manager ([fpm]), one might
replace the emulated collective subroutines with the corresponding
compiler feature by passing `--flag -DEMULATE_COLLECTIVE_SUBROUTINES`
as an argument to `fpm`.

Hope contains a few emulated procedures and preprocessor macros that
trigger their compilation.  We make no attempt at comprehensiveness. 
We support only the procedures, arguments, and argument types, kinds, 
and ranks that we have found useful in our own work.  We welcome pull 
requests that expand Hope's emulators in number or capability.

Contents
--------
Emulated features:
* Fortran 2008 intrinsic function: `findloc`
* Fortran 2018 collective subroutines: `co_sum`, `co_broadcast`

Those who find the collective subroutines useful might also be interested
in language extensions such as the [Sourcery] library's `co_all` subroutine,
which provides a parallel, collective `logical` operation analogous to the
`all` intrinsic function.

Prerequisites
-------------
Hope builds with a Fortran compiler that supports the following features:

* **Error stop**
   - Hope's only dependency, [Assert], uses Fortran 2018 `error stop`,
which several compilers have supported before supporting the features
that Hope emulates.  Please submit an [issue] or [pull request]
if you prefer to have the option to build without Assert.

* **Coarrays and synchronization**
   - Hope's Fortran 2018 collective subroutine emulators use Fortran 2008 coarrays
and synchronization.

[Sourcery]: https://github.com/sourceryinstitute/sourcery
[Assert]: https://github.com/sourceryinstitute/assert
[issue]: https://github.com/sourceryinstitute/hope/issues
[pull request]: https://github.com/sourceryinstitute/hope/pulls
[fpm]: https://github.com/fortran-lang/fpm
