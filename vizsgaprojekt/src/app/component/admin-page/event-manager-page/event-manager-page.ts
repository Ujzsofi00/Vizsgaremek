import { ChangeDetectionStrategy, Component, inject, model, OnInit } from '@angular/core';
import { MatCardModule } from '@angular/material/card';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { AppointmentService } from '../../../service/appointment-service';
import { Appointment } from '../../../models/Appointment.model';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { UserService } from '../../../service/user-service';
import { CommonModule, DatePipe } from '@angular/common';
import { User } from '../../../models/User.model';

@Component({
  selector: 'app-event-manager-page',
  imports: [MatCardModule, MatDatepickerModule, ReactiveFormsModule, CommonModule],
  templateUrl: './event-manager-page.html',
  styleUrl: './event-manager-page.scss',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class EventManagerPage implements OnInit {
  selected = model<Date | null>(null);
  appointmentService = inject(AppointmentService)
  userService = inject(UserService)

  selectedAppointment: Appointment | null = null
  editForm!: FormGroup
  isShowForm: boolean = false
  workers: User[] = []
  isOnline: boolean = false

  ngOnInit(): void {
    this.selected.set(new Date())
    this.getAppointmentByDate()
    this.userService.getAllWorker().subscribe({
      next: response => this.workers = response
    })
  }

  getAppointmentByDate() {
    this.isShowForm = false
    const formattedDate = this.selected()!.toLocaleDateString("Hu-hu").replace(". ", "-").replace(". ", "-").replace(".", "")
    this.appointmentService.getAppointmentByDate(formattedDate).subscribe({
      next: response => {
        this.selectedAppointment = response
      }
    })
  }

  showFormForCreate() {
    if (!this.isShowForm) {
      this.editForm = new FormGroup({
        workerId: new FormControl("", [Validators.required]),
        capacity: new FormControl("", [Validators.required]),
        date: new FormControl(this.selected(), [Validators.required]),
        startHour: new FormControl("", [Validators.required]),
        endHour: new FormControl("", [Validators.required]),
        title: new FormControl("", [Validators.required])
      })
    } else {
      this.appointmentService.addAppointment({
        title: this.editForm.controls["title"].value,
        date: this.editForm.controls["date"].value,
        start: this.editForm.controls["startHour"].value,
        end: this.editForm.controls["endHour"].value,
        isOnline: this.isOnline,
        capacity: this.editForm.controls["capacity"].value,
        workerId: this.editForm.controls["workerId"].value
      }).subscribe({
        next: response => {
          console.log(response)
        }
      })
    }

    this.isShowForm = !this.isShowForm
  }

  handleUpdate() {
    if (this.isShowForm) {
      this.appointmentService.updateAppointment(this.selectedAppointment?.id!, {
        title: this.editForm.controls["title"].value,
        date: this.editForm.controls["date"].value,
        start: this.editForm.controls["startHour"].value,
        end: this.editForm.controls["endHour"].value,
        isOnline: this.isOnline,
        capacity: this.editForm.controls["capacity"].value,
        workerId: this.editForm.controls["workerId"].value
      }).subscribe({
        next: response => {
          this.selectedAppointment = response
        },
        complete: () => {
          this.isShowForm = false
        }
      })
    } else {
      this.editForm = new FormGroup({
        workerId: new FormControl(this.selectedAppointment?.worker.id, [Validators.required]),
        capacity: new FormControl(this.selectedAppointment?.capacity, [Validators.required]),
        date: new FormControl(this.selectedAppointment?.date, [Validators.required]),
        startHour: new FormControl(this.selectedAppointment?.start, [Validators.required]),
        endHour: new FormControl(this.selectedAppointment?.end, [Validators.required]),
        title: new FormControl(this.selectedAppointment?.title, [Validators.required])
      })
      this.isOnline = this.selectedAppointment?.isOnline!
    }

    this.isShowForm = !this.isShowForm
  }

  deleteAppointment() {
    this.appointmentService.deleteAppointment(this.selectedAppointment?.id!).subscribe({
      next: response => {
        this.selectedAppointment = null
      }
    })
  }
}
