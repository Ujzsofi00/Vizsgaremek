import { ChangeDetectionStrategy, Component, computed, inject, model, OnInit } from '@angular/core';
import { MatCardModule } from '@angular/material/card';
import { provideNativeDateAdapter } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { Router } from '@angular/router';
import { Appointment } from '../../models/Appointment.model';
import { AppointmentService } from '../../service/appointment-service';
import { UserService } from '../../service/user-service';

@Component({
  selector: 'app-appointment-selector',
  imports: [MatCardModule, MatDatepickerModule],
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

  ngOnInit(): void {
    this.getAppointmentByDate()
  }

  getAppointmentByDate() {
    const formattedDate = this.selectedDate().toLocaleDateString("Hu-hu").replace(". ", "-").replace(". ", "-").replace(".", "")
    console.log(formattedDate)
    this.appointMentService.getAppointmentByDate(formattedDate).subscribe({
      next: response => {
        this.selectedAppointment = response
        console.log(this.selectedAppointment)
      }
    })
  }

  bookAppointment() {

  }
}