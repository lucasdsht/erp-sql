const express = require('express');
const mysql = require('mysql');
const path = require('path');
const util = require('util');
require('dotenv').config();
const app = express();
const port = process.env.PORT || 3000;

app.use(express.urlencoded({ extended: true }));

app.use(express.static(path.join(__dirname, 'public')));

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

const pool = mysql.createPool({
    connectionLimit: 10,
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME
});

pool.query = util.promisify(pool.query);

app.get('/', (req, res) => {
    res.render('index');
});

app.get('/promotions', async (req, res) => {
    try {
        const promotions = await pool.query('SELECT * FROM Promotion ORDER BY PromotionId DESC');
        const products = await pool.query('SELECT * FROM Product');
        const lastPromotion = promotions.length > 0 ? promotions[0] : null;
        res.render('promotions', { promotions, lastPromotion, products });
    } catch (err) {
        console.error('Error fetching data: ', err);
        res.sendStatus(500);
    }
});

app.get('/add-promotion', (req, res) => {
    res.render('add-promotion');
});

app.post('/add-promotion', async (req, res) => {
    const { discountRate, startDate, endDate, productId } = req.body;
    try {
        await pool.query('INSERT INTO Promotion (DiscountRate, StartDate, EndDate, ProductId) VALUES (?, ?, ?, ?)',
            [discountRate, startDate, endDate, productId]);
        res.redirect('/promotions');
    } catch (err) {
        console.error('Error adding promotion: ', err);
        res.sendStatus(500);
    }
});

app.get('/edit-promotion/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [promotion] = await pool.query('SELECT * FROM Promotion WHERE PromotionId = ?', [id]);
        res.render('edit-promotion', { promotion });
    } catch (err) {
        console.error('Error fetching promotion for edit: ', err);
        res.sendStatus(500);
    }
});

app.post('/edit-promotion/:id', async (req, res) => {
    const { id } = req.params;
    const { discountRate, startDate, endDate, productId } = req.body;
    try {
        await pool.query('UPDATE Promotion SET DiscountRate = ?, StartDate = ?, EndDate = ?, ProductId = ? WHERE PromotionId = ?',
            [discountRate, startDate, endDate, productId, id]);
        res.redirect('/promotions');
    } catch (err) {
        console.error('Error updating promotion: ', err);
        res.sendStatus(500);
    }
});

app.get('/delete-promotion/:id', async (req, res) => {
    const { id } = req.params;
    try {
        await pool.query('DELETE FROM LastPromotion WHERE PromotionId = ?', [id]);
        await pool.query('DELETE FROM Promotion WHERE PromotionId = ?', [id]);
        res.redirect('/promotions');
    } catch (err) {
        console.error('Error deleting promotion: ', err);
        res.sendStatus(500);
    }
});

app.get('/products', async (req, res) => {
    try {
        const products = await pool.query('SELECT * FROM Product ORDER BY ProductId DESC');
        res.render('products', { products });
    } catch (err) {
        console.error('Error fetching products: ', err);
        res.sendStatus(500);
    }
});

app.listen(port, () => console.log(`Server listening on port ${port}`));

