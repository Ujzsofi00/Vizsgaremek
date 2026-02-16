import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Faculty } from '../models/Faculty.model';

@Injectable({
  providedIn: 'root',
})
export class FacultyService {
  private http = inject(HttpClient)
  baseUrl: string = "http://localhost:8080/faculty"

  getAllFaculty(): Observable<Faculty[]> {
    return this.http.get<Faculty[]>(this.baseUrl)
  }
}