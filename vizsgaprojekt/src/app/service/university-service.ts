import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { university } from '../models/University.model';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class UniversityService {
  private http = inject(HttpClient)
  private baseUrl: string = "http://localhost:8080/university"

  getUniversityByName(name: string): Observable<university[]> {
    return this.http.get<university[]>(`${this.baseUrl}/${name}`)
  }

  getAllUniversity(): Observable<university[]> {
    return this.http.get<university[]>(this.baseUrl)
  }

  deleteUniversity(id: number) {
    return this.http.delete(`${this.baseUrl}/${id}`)
  }

  updateUniversity(updatedUniversity: university): Observable<university> {
    return this.http.put<university>(this.baseUrl, updatedUniversity)
  }

  addUniversity(newUniversity: university): Observable<university> {
    return this.http.post<university>(this.baseUrl, newUniversity)
  }
}
