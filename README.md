Emulators
=========

Motivation and Usage
--------------------

Are you hoping for a world with full compiler support for recent Fortran
standards?  Emulating an unsupported feature facilitates using the feature prior
to compiler support.  This path offers minimal impact on future code. Switching
to the compiler's version of a feature might involve little more than toggling a
preprocessor macro:
```fortran
#ifdef EMULATE_COLLECTIVES
  use collectives_m, only : co_sum
#endif
```
and then not passing the macro at `EMULATE_COLLECTIVES` to the compiler to
turn eliminate the emulated version of `co_sum` from the source code before
compiling.

Emulators contains a few emulated procedures and preprocessor macros that
trigger their compilation.  We make no attempt at comprehensiveness. 
We support only the procedures, arguments, and argument types, kinds, 
and ranks that we have found useful in our own work.  We welcome pull 
requests that expand Emulators's emulators in number or capability.

Contents
--------
Emulated features:
* Fortran 2008 intrinsic function: `findloc`
* Fortran 2018 collective subroutines: `co_sum`, `co_broadcast`

Those who find the collective subroutines useful might also be interested
in language extensions such as the [Sourcery] library's `co_all` subroutine,
which provides a parallel, collective `logical` operation analogous to the
`all` intrinsic function.

Documentation
-------------
See the [Emulators GitHub Pages site] for HTML documentation generated with [`ford`].

Prerequisites
-------------
Emulators builds with a Fortran compiler that supports the following features:

* **Error stop**
   - Emulators's only dependency, [Assert], uses Fortran 2018 `error stop`,
     which several compilers have supported before supporting the features
     that Emulators emulates.  Please submit an [issue] or [pull request]
     if you prefer to have the option to build without Assert.

* **Coarrays and synchronization**
   - Emulators's Fortran 2018 collective-subroutine emulators use Fortran 2008
     coarrays and synchronization.

Downloading, building and testing
---------------------------------
### Parallel execution
With `gfortran` and OpenCoarrays installed, execute the following commands in
a `bash`-like shell to include all emulators in the build:
```
git clone git@github.com:sourceryinstitute/emulators
fpm test \
  --runner cafrun -n 2 \
  --compiler caf \
  --flag "-cpp -DEMULATE_INTRINSICS -DEMULATE_COLLECTIVES"
```

### Serial execution
With `gfortran` installed, execute the following commands in
a `bash`-like shell to include all emulators in the build:
```
git clone git@github.com:sourceryinstitute/emulators
fpm test --flag "-cpp -DEMULATE_INTRINSICS -DEMULATE_COLLECTIVES -fcoarray=single"
```

[Sourcery]: https://github.com/sourceryinstitute/sourcery
[Assert]: https://github.com/sourceryinstitute/assert
[issue]: https://github.com/sourceryinstitute/hope/issues
[pull request]: https://github.com/sourceryinstitute/hope/pulls
[fpm]: https://github.com/fortran-lang/fpm
[Emulators GitHub Pages site]: http://sourceryinstitute.github.io/emulators/
[`ford`]: https://github.com/Fortran-FOSS-Programmers/ford
