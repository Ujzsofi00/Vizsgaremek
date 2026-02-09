import { inject, Injectable } from '@angular/core';
import { User } from '../models/User.model';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  private http = inject(HttpClient)
  private baseUrl = "http://localhost:8080/users"
  loggedUser: User | null = null

  login (username: string, password: string): Observable<User> {
    return this.http.post<User>(`${this.baseUrl}/login`, {username: username, password: password})
  }

  register(newUser: User) {
    return this.http.post(`${this.baseUrl}/register`, newUser)
  }
}