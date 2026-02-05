import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { AppointmentSelector } from '../component/appointment-selector/appointment-selector';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class AppointmentService {
  private http = inject(HttpClient)

  getAppointmentByDate(date: Date): Observable<AppointmentSelector> {
    return this.http.get<AppointmentSelector>("")
  }
}