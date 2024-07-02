<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>HOUSEKEEPER</title>

    {{-- STYLES --}}
    @yield('styles')

</head>

<body>
    {{-- INCLUDE THE HEADER --}}
    @include('admin.layout.header')

    {{-- INCLUDE THE SIDEBAR --}}
    @include('admin.layout.sidebar')

    {{-- INCLUDE THE PAGE CONTENT --}}
    @yield('content')

    {{-- INCLUDE THE FOOTER --}}
    @include('admin.layout.footer')

    {{-- SCRIPTS --}}
    @yield('scripts')
</body>

</html>