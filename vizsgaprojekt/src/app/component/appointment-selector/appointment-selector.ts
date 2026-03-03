import { ChangeDetectionStrategy, Component, computed, inject, model, OnInit,  } from '@angular/core';
import { MatCardModule } from '@angular/material/card';
import { provideNativeDateAdapter } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { Router } from '@angular/router';
import { Appointment } from '../../models/Appointment.model';
import { AppointmentService } from '../../service/appointment-service';
import { UserService } from '../../service/user-service';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-appointment-selector',
  imports: [MatCardModule, MatDatepickerModule, CommonModule],
  templateUrl: './appointment-selector.html',
  styleUrl: './appointment-selector.scss',
  providers: [provideNativeDateAdapter()],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class AppointmentSelector implements OnInit{
  selectedDate = model<Date>(new Date());
  selectedAppointment: Appointment | null = null
  private appointMentService = inject(AppointmentService)
  private userService = inject(UserService)
  private router = inject(Router)
  isShowBookButton: boolean = false

  ngOnInit(): void {
    this.getAppointmentByDate()
  }

  getAppointmentByDate() {
    const formattedDate = this.selectedDate().toLocaleDateString("Hu-hu").replace(". ", "-").replace(". ", "-").replace(".", "")
    this.appointMentService.getAppointmentByDate(formattedDate).subscribe({
      next: response => {
        console.log("")
        this.selectedAppointment = response
        // this.selectedAppointment.reserverUsers = []
      },
      complete: () => {
        this.isShowBookButton = this.selectedAppointment?.reserverUsers.map(u => u.id).includes(this.userService.loggedUser?.id!)!
      }
    })
  }

  bookAppointment() {
    this.appointMentService.bookAppointment(this.selectedAppointment?.id!, this.userService.loggedUser?.id!).subscribe({
      next: response => {
        this.isShowBookButton = true
      }
    })
  }
}