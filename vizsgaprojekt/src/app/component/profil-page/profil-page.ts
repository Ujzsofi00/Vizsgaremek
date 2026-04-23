import { Component, inject, OnInit } from '@angular/core';
import { UserService } from '../../service/user-service';
import { AppointmentService } from '../../service/appointment-service';
import { Appointment } from '../../models/Appointment.model';
import { AppointmentCard } from './appointment-card/appointment-card';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-profil-page',
  imports: [AppointmentCard, ReactiveFormsModule],
  templateUrl: './profil-page.html',
  styleUrl: './profil-page.css',
})
export class ProfilPage  implements OnInit {
  userService = inject(UserService)
  appointmentService = inject(AppointmentService)
  appointments: Appointment[] = []
  showConfirmation: boolean = false
  selectedAppointmentId: number | null = null
  router = inject(Router)
  updateForm!: FormGroup;

  ngOnInit(): void {
    this.appointmentService.getAppointmentsByUserId(this.userService.loggedUser?.id!).subscribe({
      next: response => this.appointments = response
    })

    this.updateForm = new FormGroup({
      firstName: new FormControl("", [Validators.required]),
      lastName: new FormControl("", [Validators.required]),
      email: new FormControl("", [Validators.required, Validators.email]),
      username: new FormControl("", [Validators.required])
    })
  }


  updateUser() {

  }


  deleteUser() {
    this.userService.deleteUser(this.userService.loggedUser!.id!).subscribe({
      complete:() => {
        this.userService.loggedUser = null
        this.closeConfirmation()
        this.router.navigate(["/homePage"])
      }
    })
  }

  closeConfirmation() {
    this.showConfirmation = false
    this.selectedAppointmentId = null
  }
}