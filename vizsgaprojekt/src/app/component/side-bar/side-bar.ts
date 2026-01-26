import { Component, inject, output } from '@angular/core';
import { Router, RouterModule } from '@angular/router';
import { User } from '../../models/User.model'; 
import { UserService } from '../../service/user-service';

@Component({
  selector: 'app-side-bar',
  imports: [],
  templateUrl: './side-bar.html',
  styleUrl: './side-bar.scss',
})
export class SideBar {
  private router = inject(Router)
  userService = inject(UserService)
  close = output()

  navigate(path: string) {
    this.router.navigate([path])
    this.close.emit()
  }
}
