# F9 Corner Detection Library

**F9 Corner Detection Library** is an open source implementation of the [FAST-9 corner detection algorithm](http://www.edwardrosten.com/work/fast.html), which avoids many re-allocations and tries to generally perform better.

The library consists of a single source file (__f9.cpp__) and a public header file (__f9.h__), and can be packaged as a static or shared library as well as built directly into your projects.

## API

See [f9.h](//github.com/jcayzac/F9-Corner-Detection-Library/blob/master/f9.h).

**Multithread support:** The F9 context (C API) and the F9 class (C++ API) are not thread-safe, but it's easy to create one of these for each thread where you need to perform corner detection (the library _is_ reentrant). You could for instance split a big image in four tiles and detect its corners in four threads, using four F9 contexts/instances in total.

## License

This code is released under the terms of the Simplified BSD License below.

```
Copyright 2011 Julien Cayzac. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

   1. Redistributions of source code must retain the above copyright notice,
      this list of conditions and the following disclaimer.

   2. Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS "AS IS" AND ANY EXPRESS
OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

The views and conclusions contained in the software and documentation are
those of the authors and should not be interpreted as representing official
policies, either expressed or implied, of the copyright holders.
```
