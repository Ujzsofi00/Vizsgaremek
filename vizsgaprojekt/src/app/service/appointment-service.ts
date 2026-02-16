import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Appointment } from '../models/Appointment.model';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class AppointmentService {
  private http = inject(HttpClient)
  private baseUrl: string = "http://localhost:8080/appointment"

  getAppointmentByDate(date: string): Observable<Appointment> {
    return this.http.get<Appointment>(`${this.baseUrl}/${date}`)
  }

  bookAppointment(appointmentId: number, userId: number) {
    return this.http.post(`${this.baseUrl}/book`, {})
  }
}