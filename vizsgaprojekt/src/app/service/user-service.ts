import { inject, Injectable } from '@angular/core';
import { User } from '../models/User.model';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  private http = inject(HttpClient)
  private baseUrl = "http://localhost:8080/users"
  loggedUser: User | null = null

  login (username: string, password: string) {
    return this.http.post(`${this.baseUrl}/login`, {username: username, password: password})
  }

  register(newUser: User) {
    return this.http.post(`${this.baseUrl}/register`, newUser)
  }
}