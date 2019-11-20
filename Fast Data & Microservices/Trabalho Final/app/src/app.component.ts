import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html'
})
export class AppComponent implements OnInit {

  api = 'http://localhost:3000';

  nome: string;
  rm: string;
  alunos: Array<{ nome: string, rm: string }>;

  constructor(private http: HttpClient) {
  }

  ngOnInit() {
    this.http.get(this.api).subscribe((alunos: any) => {
      this.alunos = alunos;
    }, () => alert('Erro ao conectar ao retornar os dados da API'));
  }

  cadastrar() {
    this.http.post(this.api, { nome: this.nome, rm: this.rm }).subscribe(() => {
      this.nome = '';
      this.rm = '';
      this.ngOnInit();
    }, () => alert('Erro ao cadastrar'));
  }
}
