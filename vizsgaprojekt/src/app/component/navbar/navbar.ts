import { Component, inject, output } from '@angular/core';
import { RouterModule } from '@angular/router';
import { UserService } from '../../service/user-service';

@Component({
  selector: 'app-navbar',
  imports: [RouterModule],
  templateUrl: './navbar.html',
  styleUrl: './navbar.scss',
})
export class Navbar {
  showSideBar = output()
  userService = inject(UserService)
}