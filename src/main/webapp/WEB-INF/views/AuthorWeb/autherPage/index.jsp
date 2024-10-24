<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Snake Game</title>
    <style>
        body {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }

        h1 {
            margin-bottom: 20px;
        }

        canvas {
            border: 1px solid #000;
        }
    </style>
</head>
<body>
    <h1>Snake Game</h1>
    <canvas id="gameCanvas" width="400" height="400"></canvas>
    <script>
        const canvas = document.getElementById('gameCanvas');
        const ctx = canvas.getContext('2d');

        const gridSize = 20;
        const tileCount = canvas.width / gridSize;
        let snake = [{ x: 10, y: 10 }];
        let direction = { x: 0, y: 0 };
        let apple = { x: 15, y: 15 };

        function gameLoop() {
            update();
            draw();
            setTimeout(gameLoop, 100);
        }

        function update() {
            const head = { x: snake[0].x + direction.x, y: snake[0].y + direction.y };

            // Check if the snake has eaten the apple
            if (head.x === apple.x && head.y === apple.y) {
                apple = { x: Math.floor(Math.random() * tileCount), y: Math.floor(Math.random() * tileCount) };
            } else {
                snake.pop();
            }

            snake.unshift(head);

            // Check for collisions with walls
            if (head.x < 0 || head.x >= tileCount || head.y < 0 || head.y >= tileCount) {
                resetGame();
            }

            // Check for collisions with itself
            for (let i = 1; i < snake.length; i++) {
                if (head.x === snake[i].x && head.y === snake[i].y) {
                    resetGame();
                }
            }
        }

        function draw() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);

            // Draw the snake
            snake.forEach(segment => {
                ctx.fillStyle = 'green';
                ctx.fillRect(segment.x * gridSize, segment.y * gridSize, gridSize, gridSize);
            });

            // Draw the apple
            ctx.fillStyle = 'red';
            ctx.fillRect(apple.x * gridSize, apple.y * gridSize, gridSize, gridSize);
        }

        function resetGame() {
            snake = [{ x: 10, y: 10 }];
            direction = { x: 0, y: 0 };
        }

        document.addEventListener('keydown', event => {
            switch (event.key) {
                case 'ArrowUp':
                    if (direction.y === 0) direction = { x: 0, y: -1 };
                    break;
                case 'ArrowDown':
                    if (direction.y === 0) direction = { x: 0, y: 1 };
                    break;
                case 'ArrowLeft':
                    if (direction.x === 0) direction = { x: -1, y: 0 };
                    break;
                case 'ArrowRight':
                    if (direction.x === 0) direction = { x: 1, y: 0 };
                    break;
            }
        });

        gameLoop();
    </script>
</body>
</html>
