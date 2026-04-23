import { Component, inject, OnInit } from '@angular/core';
import { UserService } from '../../service/user-service';
import { Router } from '@angular/router';
import {
  AbstractControl,
  FormControl,
  FormGroup,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';

function validatePassword(control: AbstractControl): { [key: string]: any } | null {
  const password: string = control.value;
  const specialCharacters: string = '!@#$%^&*()-_=+[]{};:,.?/';
  const numberTexts: string = '1234567890';
  const checkerList: boolean[] = [false, false, false, false];

  for (let i: number = 0; i < password.length; i++) {
    if (specialCharacters.includes(password[i])) {
      checkerList[0] = true;
    } else if (numberTexts.includes(password[i])) {
      checkerList[1] = true;
    } else if (password[i] === password[i].toUpperCase()) {
      checkerList[2] = true;
    } else if (password[i] === password[i].toLowerCase()) {
      checkerList[3] = true;
    }
  }

  if (!checkerList.includes(false)) {
    return null;
  } else {
    return { invalid: false };
  }
}

@Component({
  selector: 'app-password-reset',
  imports: [ReactiveFormsModule],
  templateUrl: './password-reset.html',
  styleUrl: './password-reset.scss',
})
export class PasswordReset implements OnInit {
  userService = inject(UserService);
  router = inject(Router);
  form!: FormGroup;
  showPasswordInputs: boolean = false;

  samePasswordValidator = (control: AbstractControl): { [key: string]: any } | null => {
    let originalPassword = this.form.controls['newPassword'].value;
    if (control.value === originalPassword) {
      return null;
    } else {
      return { invalid: false };
    }
  };

  ngOnInit(): void {
    this.form = new FormGroup({
      email: new FormControl('', [Validators.required, Validators.email]),
      verificationCode: new FormControl('', [Validators.required]),
      newPassword: new FormControl('', [Validators.required, validatePassword]),
      newPasswordAgain: new FormControl('', [Validators.required]),
    });
    this.form.controls['newPasswordAgain'].addValidators(this.samePasswordValidator);
  }

  getCode() {
    this.userService.getVerificationCode(this.form.controls['email'].value).subscribe({
      next: (response) => console.log(response),
    });
  }

  checkVCode(vCodeInputValue: string) {
    if (vCodeInputValue.length == 10) {
      console.log(this.form.controls['email'].value)
      console.log(vCodeInputValue)
      this.userService
        .checkVerificationCode(vCodeInputValue, this.form.controls['email'].value)
        .subscribe({
          next: (response) => {
            console.log(response);
            this.showPasswordInputs = response;
          },
        });
    }
  }

  sendReset() {
    this.userService
      .passwordReset(this.form.controls['email'].value, this.form.controls['newPassword'].value, this.form.controls['verificationCode'].value)
      .subscribe({
        next: (response) => console.log(response),
        complete: () => {
          this.router.navigate(['/login']);
        },
      });
  }
}
