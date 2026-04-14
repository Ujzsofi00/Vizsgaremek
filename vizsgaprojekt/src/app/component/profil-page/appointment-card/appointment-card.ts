import { Component, input, output } from '@angular/core';
import { Appointment } from '../../../models/Appointment.model';

@Component({
  selector: 'app-appointment-card',
  imports: [],
  templateUrl: './appointment-card.html',
  styleUrl: './appointment-card.css',
})
export class AppointmentCard {
  appointment = input.required<Appointment>()
  startCanelling = output<number>()


  cancelReservation() {
    this.startCanelling.emit(this.appointment().id!)
  }
}