import { Component, signal } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { Login } from "./component/login/login";
import { Header } from "./component/header/header";
import { Register } from "./component/register/register";
import { Home } from "./component/home/home";

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, Login, Header, Register, Home],
  templateUrl: './app.html',
  styleUrl: './app.css'
})
export class App {
  protected readonly title = signal('vizsgaprojekt');
}
