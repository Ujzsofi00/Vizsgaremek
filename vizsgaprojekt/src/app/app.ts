import { Component, signal } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { Navbar } from './component/navbar/navbar'; 
import { SideBar } from './component/side-bar/side-bar';
import { Footer } from './component/footer/footer'; 

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, Navbar, SideBar, Footer],
  templateUrl: './app.html',
  styleUrl: './app.scss'
})
export class App {
  isShowSideBar: boolean = false
}
