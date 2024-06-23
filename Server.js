const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();
const port = process.env.PORT || 3000;

// Conexión a la base de datos MySQL
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'Sebas123',
    database: 'biblioteca'
});

db.connect((err) => {
    if (err) {
        throw err;
    }
    console.log('MySQL conectado...');
});

app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, 'public')));

// Ruta para servir index.html
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Endpoints para estudiantes
app.get('/api/estudiantes', (req, res) => {
    const sql = 'SELECT * FROM estudiantes';
    db.query(sql, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

app.post('/api/estudiantes', (req, res) => {
    const { nombre, documento, programa } = req.body;
    const sql = 'INSERT INTO estudiantes SET ?';
    db.query(sql, { nombre, documento, programa }, (err, result) => {
        if (err) throw err;
        res.json({ id: result.insertId, nombre, documento, programa });
    });
});

app.delete('/api/estudiantes/:id', (req, res) => {
    const { id } = req.params;
    const sql = 'DELETE FROM estudiantes WHERE id = ?';
    db.query(sql, [id], (err, result) => {
        if (err) throw err;
        res.sendStatus(200);
    });
});

// Endpoints para libros
app.get('/api/libros', (req, res) => {
    const sql = 'SELECT * FROM libros';
    db.query(sql, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

app.post('/api/libros', (req, res) => {
    const { autor, fecha_nacimiento, lugar_nacimiento, nombre_libro, fecha_publicacion } = req.body;
    const sql = 'INSERT INTO libros SET ?';
    db.query(sql, { autor, fecha_nacimiento, lugar_nacimiento, nombre_libro, fecha_publicacion }, (err, result) => {
        if (err) throw err;
        res.json({ id: result.insertId, autor, fecha_nacimiento, lugar_nacimiento, nombre_libro, fecha_publicacion });
    });
});

app.delete('/api/libros/:id', (req, res) => {
    const { id } = req.params;
    const sql = 'DELETE FROM libros WHERE id = ?';
    db.query(sql, [id], (err, result) => {
        if (err) throw err;
        res.sendStatus(200);
    });
});

// Iniciar el servidor
app.listen(port, () => {
    console.log(`Servidor ejecutándose en el puerto ${port}`);
});

