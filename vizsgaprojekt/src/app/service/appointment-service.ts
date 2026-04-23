import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Appointment } from '../models/Appointment.model';
import { Observable } from 'rxjs';

interface appointmentDto {
  title: string,
  date: string,
  start: string,
  end: string,
  isOnline: boolean,
  capacity: number,
  workerId: number
}

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
    return this.http.post(`${this.baseUrl}/${appointmentId}/book`, { userId: userId })
  }

  deleteAppointment(id: number) {
    return this.http.delete(`${this.baseUrl}/${id}`)
  }

  updateAppointment(id: number, updatedAppointment: appointmentDto): Observable<Appointment> {
    return this.http.put<Appointment>(`${this.baseUrl}/${id}`, updatedAppointment)
  }

  addAppointment(newAppointment: appointmentDto) {
    return this.http.post(`${this.baseUrl}`, newAppointment)
  } 

   getAppointmentsByUserId(userId: number): Observable<Appointment[]> {
    return this.http.get<Appointment[]>(`${this.baseUrl}/user/${userId}`)
  }


  cancelReservation(appointmentId: number, userId: number) {
    return this.http.delete(`${this.baseUrl}/cancel?appointmentId=${appointmentId}&userId=${userId}`)
  }
}