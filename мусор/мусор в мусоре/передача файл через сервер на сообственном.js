const express = require('express');
const multer = require('multer');
const path = require('path');
const fs = require('fs');

// Инициализация express
const app = express();
const port = 3000;

// Настройка хранилища для файлов
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        const uploadPath = path.join(__dirname, 'uploads');
        if (!fs.existsSync(uploadPath)) {
            fs.mkdirSync(uploadPath);
        }
        cb(null, uploadPath);
    },
    filename: function (req, file, cb) {
        cb(null, Date.now() + path.extname(file.originalname));
    }
});

const upload = multer({ storage: storage });

// Маршрут для загрузки файлов
app.post('/upload', upload.single('file'), (req, res) => {
    if (!req.file) {
        return res.status(400).send('Не удалось загрузить файл.');
    }
    res.json({ message: 'Файл успешно загружен!', filename: req.file.filename });
});

// Статический сервер для загрузки HTML-файла
app.use(express.static(__dirname));

app.listen(port, () => {
    console.log(`Сервер запущен на http://localhost:${port}`);
});
