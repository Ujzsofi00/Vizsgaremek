import { Component, inject, OnInit } from '@angular/core';
import { UserService } from '../../service/user-service';
import { AppointmentService } from '../../service/appointment-service';
import { Appointment } from '../../models/Appointment.model';
import { AppointmentCard } from './appointment-card/appointment-card';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';

@Component({
  selector: 'app-profil-page',
  imports: [AppointmentCard, ReactiveFormsModule, RouterModule],
  templateUrl: './profil-page.html',
  styleUrl: './profil-page.css',
})
export class ProfilPage implements OnInit {
  userService = inject(UserService);
  appointmentService = inject(AppointmentService);
  appointments: Appointment[] = [];
  showConfirmation: boolean = false;
  showInputs: boolean = false;
  router = inject(Router);
  updateForm!: FormGroup;

  ngOnInit(): void {
    this.appointmentService.getAppointmentsByUserId(this.userService.loggedUser?.id!).subscribe({
      next: (response) => (this.appointments = response),
    });

    this.updateForm = new FormGroup({
      firstName: new FormControl(this.userService.loggedUser?.firstName, [Validators.required]),
      lastName: new FormControl(this.userService.loggedUser?.lastName, [Validators.required]),
      email: new FormControl(this.userService.loggedUser?.email, [
        Validators.required,
        Validators.email,
      ]),
      username: new FormControl(this.userService.loggedUser?.username, [Validators.required]),
    });
  }

  handleUpdate() {
    if (this.showInputs) {
      this.updateUser();
    }
    this.showInputs = !this.showInputs;
  }

  updateUser() {
    this.userService
      .updateUser(this.userService.loggedUser!.id!, {
        username: this.updateForm.value.username,
        firstName: this.updateForm.value.firstName,
        lastName: this.updateForm.value.lastName,
        email: this.updateForm.value.email,
      })
      .subscribe({
        next: (response) => (this.userService.loggedUser = response),
      });
  }

  cancelAppointment(selectedAppointmentId: number, index: number) {
    this.appointmentService.cancelReservation(selectedAppointmentId!, this.userService.loggedUser!.id!).subscribe({
      next: (response) => {
        this.appointments.splice(index, 1);
      }
    });
  }

  deleteUser() {
    this.userService.deleteUser(this.userService.loggedUser!.id!).subscribe({
      complete: () => {
        this.userService.loggedUser = null;
        this.showConfirmation = false;
        this.router.navigate(['/homePage']);
      },
    });
  }
}