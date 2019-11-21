const express = require('express');
const mongoose = require('mongoose');

const router = express.Router();

mongoose.connect('mongodb://database:27017/test', { useNewUrlParser: true });

const Aluno = mongoose.model('Aluno', { nome: String, rm: String });

router.get('/', (req, res) => {
    Aluno.find({}).sort('nome').exec(function (err, alunos) {
        res.send(alunos);
    });    
});

router.post('/', (req, res) => {
    const aluno = new Aluno({
        nome: req.body.nome, 
        rm: req.body.rm
    });
    aluno.save();
    res.send(aluno);
});

module.exports = router;
