<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Welcome to Streamify</title>
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,600" rel="stylesheet">
    <style>
        html, body {
            background-color: #e4e6ec;
            color: #2d22ca;
            font-family: 'Nunito', sans-serif;
            height: 100vh;
            margin: 0;
        }
        .flex-center {
            align-items: center;
            display: flex;
            justify-content: center;
            height: 100%;
            text-align: center;
        }
        .title {
            font-size: 3rem;
            font-weight: 600;
        }
        .subtitle {
            font-size: 1.5rem;
            margin-top: 1rem;
        }
        .button {
            margin-top: 2rem;
            padding: 0.75rem 2rem;
            background-color: #f5f6f9;
            color: rgb(45, 45, 182);
            border-radius: 0.5rem;
            text-decoration: none;
            font-weight: bold;
        }
        .button:hover {
            background-color: #1D4ED8;
        }
    </style>
</head>
<body>
    <div class="flex-center">
        <div>
            <div class="title">Welcome to Streamify 🎬</div>
            <div class="subtitle">Your all-in-one platform to stream, share, and explore amazing content.</div>
        <div class="mt-200">
        <a href="/register" class="button">Get Started</a>
        </div>
        </div>
    </div>
</body>
</html>
