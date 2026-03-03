import { Component, inject, OnInit } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { UserService } from '../../service/user-service';
import { Router, RouterModule } from '@angular/router';

@Component({
  selector: 'app-login',
  imports: [ReactiveFormsModule, RouterModule],
  templateUrl: './login.html',
  styleUrl: './login.scss',
})
export class Login implements OnInit {
  userService = inject(UserService)
  router = inject(Router)
  loginForm!: FormGroup;
  isError: boolean = false
  errorMsg: string = ""

  ngOnInit(): void {
    this.loginForm = new FormGroup({
      username: new FormControl("", [Validators.required]),
      password: new FormControl("", [Validators.required])
    })
  }

  login() {
    this.userService.login(this.loginForm.controls["username"].value, this.loginForm.controls["password"].value).subscribe({
      next: response => this.userService.loggedUser = response,
      error: (error) =>  {
        if (error.status == 401) {
          this.isError = true
          this.errorMsg = "Nincs ilyen felhasználó regisztrálva. Próbáld meg újra!"
        } else {
          this.isError = true
          this.errorMsg = "Hiba történt! Kérlek próbáld újra!"
        }
      },
      complete: () => {
        console.log(this.userService.loggedUser)
        this.router.navigate(["/homePage"])
      }
    })
  }
}