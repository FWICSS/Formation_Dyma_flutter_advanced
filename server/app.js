const express = require('express');
const mongoose = require('mongoose');
const index = require('./routes');
require('dotenv').config();

const DB_USERNAME = process.env.DB_USERNAME;
const DB_PASSWORD = process.env.DB_PASSWORD;

try {
    mongoose
        .connect(
            `mongodb+srv://${DB_USERNAME}:${DB_PASSWORD}@clustor.7wtz64j.mongodb.net/flutter-ath?retryWrites=true&w=majority`
        )
        .then(() => console.log('DB CONNECTED'));
} catch (error) {
    console.log('ERROR DB');
}

// try {
//     mongoose
//         .connect(
//             `mongodb+srv://${DB_USERNAME}:${DB_PASSWORD}@clustor.7wtz64j.mongodb.net/flutter-ath?retryWrites=true&w=majority`, {
//                 useNewUrlParser: true,
//                 useUnifiedTopology: true // Ajoutez également cette option
//             })
//         .then(() => console.log('DB CONNECTED'))
//         .catch(err => console.error('DB CONNECTION ERROR:', err));
// } catch (error) {
//     console.log('ERROR DB');
// }

const app = express();

app.use(express.json());
app.use(express.urlencoded({extended: false}));

app.use(index);

app.all('*', (req, res) => {
    res.status(404).json('not-found');
});

app.use((err, req, res, next) => {
    console.log(err);
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};

    res.status(err.status || 500);
    res.json('error');
});

module.exports = app;