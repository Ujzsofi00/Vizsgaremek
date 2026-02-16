import { ChangeDetectionStrategy, Component, inject, OnInit, signal } from '@angular/core';
import { UserService } from '../../../service/user-service';
import { User } from '../../../models/User.model';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatPaginatorModule } from '@angular/material/paginator';
import { M } from '@angular/cdk/keycodes';

@Component({
  selector: 'app-user-list',
  imports: [MatCheckboxModule, MatPaginatorModule],
  templateUrl: './user-list.html',
  styleUrl: './user-list.scss',
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class UserList implements OnInit{
  userService = inject(UserService)
  users = signal<User[]>([])

  ngOnInit(): void {
    this.userService.getAllUser().subscribe({
      next: response =>{
        this.users.set(response)
        console.log(response)
      },
      complete: () => {
        console.log(this.users())
      }
    })
  }


  deleteUser(selectedUser: User) {
    this.userService.deleteUser(selectedUser.id!).subscribe({
      next: response => {
        this.users.update(old => old.filter(user => user.id != selectedUser.id))
      }
    })
  }


  changeRoleOfUser(selectedUser: User, index: number) {
    this.userService.changeRoleOfUser(selectedUser.id!).subscribe({
      next: response => {
        this.users.update(old => [
          ...old.slice(0, index),
          response,
          ...old.slice(index+1)
        ])
      }, complete: () => {
        console.log(this.users())
      }
    })
  }
}
