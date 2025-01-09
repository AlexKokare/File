<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chess Raze 0.0</title>
    <style>
        body {
            background-color: #000;
            color: #fff;
            font-family: Arial, sans-serif;
            margin: 0;
            overflow: hidden;
        }
        #game-board {
            display: grid;
            grid-template-columns: repeat(8, 1fr);
            grid-template-rows: repeat(8, 1fr);
            width: 80vmin;
            height: 80vmin;
            margin: auto;
            margin-top: 5%;
            border: 5px solid #fff;
            box-shadow: 0 0 20px rgba(255, 255, 255, 0.8);
        }
        .tile {
            width: 100%;
            height: 100%;
        }
        .tile:nth-child(even) {
            background-color: #444;
        }
        .tile:nth-child(odd) {
            background-color: #888;
        }
        .piece {
            width: 80%;
            height: 80%;
            margin: auto;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            color: #fff;
            font-size: 1.5rem;
        }
    </style>
</head>
<body>
    <div id="game-board"></div>

    <script>
        const board = document.getElementById('game-board');

        // Initialize board state
        let gameState = {
            board: Array(8).fill().map(() => Array(8).fill(null))
        };

        // Set initial pieces
        gameState.board[0][0] = "♜";
        gameState.board[0][7] = "♜";

        // Render the chess board
        function renderBoard() {
            board.innerHTML = '';
            for (let row = 0; row < 8; row++) {
                for (let col = 0; col < 8; col++) {
                    const tile = document.createElement('div');
                    tile.classList.add('tile');
                    board.appendChild(tile);

                    if (gameState.board[row][col]) {
                        const piece = document.createElement('div');
                        piece.classList.add('piece');
                        piece.textContent = gameState.board[row][col];
                        tile.appendChild(piece);
                    }
                }
            }
        }

        // Save game state to localStorage
        function saveGame() {
            localStorage.setItem('chessGameState', JSON.stringify(gameState));
            alert('Game saved!');
        }

        // Load game state from localStorage
        function loadGame() {
            const savedState = localStorage.getItem('chessGameState');
            if (savedState) {
                gameState = JSON.parse(savedState);
                renderBoard();
                alert('Game loaded!');
            } else {
                alert('No saved game found.');
            }
        }

        // Enable piece movement
        let selectedPiece = null;

        board.addEventListener('click', (e) => {
            const target = e.target;

            // Select a piece
            if (target.classList.contains('piece')) {
                selectedPiece = target;
                selectedPiece.style.backgroundColor = 'rgba(255, 0, 0, 0.5)';
            } else if (selectedPiece && target.classList.contains('tile')) {
                // Move the piece
                const pieceRow = Array.from(board.children).indexOf(selectedPiece.parentElement) / 8 | 0;
                const pieceCol = Array.from(selectedPiece.parentElement.parentElement.children).indexOf(selectedPiece.parentElement) % 8;
                const targetRow = Array.from(board.children).indexOf(target) / 8 | 0;
                const targetCol = Array.from(target.parentElement.children).indexOf(target) % 8;

                gameState.board[pieceRow][pieceCol] = null;
                gameState.board[targetRow][targetCol] = selectedPiece.textContent;

                target.appendChild(selectedPiece);
                selectedPiece.style.backgroundColor = 'rgba(255, 255, 255, 0.3)';
                selectedPiece = null;
            }
        });

        // Add navigation and control buttons
        const navButton = document.createElement('button');
        navButton.textContent = 'Next Page';
        navButton.style.position = 'absolute';
        navButton.style.bottom = '10px';
        navButton.style.left = '50%';
        navButton.style.transform = 'translateX(-50%)';
        navButton.style.padding = '10px 20px';
        navButton.style.fontSize = '1rem';
        navButton.style.cursor = 'pointer';
        document.body.appendChild(navButton);

        navButton.addEventListener('click', () => {
            window.location.href = 'next_page.html';
        });

        const saveButton = document.createElement('button');
        saveButton.textContent = 'Save Game';
        saveButton.style.position = 'absolute';
        saveButton.style.bottom = '50px';
        saveButton.style.left = '50%';
        saveButton.style.transform = 'translateX(-50%)';
        saveButton.style.padding = '10px 20px';
        saveButton.style.fontSize = '1rem';
        saveButton.style.cursor = 'pointer';
        document.body.appendChild(saveButton);

        saveButton.addEventListener('click', saveGame);

        const loadButton = document.createElement('button');
        loadButton.textContent = 'Load Game';
        loadButton.style.position = 'absolute';
        loadButton.style.bottom = '90px';
        loadButton.style.left = '50%';
        loadButton.style.transform = 'translateX(-50%)';
        loadButton.style.padding = '10px 20px';
        loadButton.style.fontSize = '1rem';
        loadButton.style.cursor = 'pointer';
        document.body.appendChild(loadButton);

        loadButton.addEventListener('click', loadGame);

        // Initial render
        renderBoard();
    </script>
</body>
</html>
