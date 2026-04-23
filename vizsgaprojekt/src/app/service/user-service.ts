import { inject, Injectable } from '@angular/core';
import { User } from '../models/User.model';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  private http = inject(HttpClient)
  private baseUrl = "http://localhost:8080/user"
  loggedUser: User | null = null

  login (username: string, password: string): Observable<User> {
    return this.http.post<User>(`${this.baseUrl}/login`, {username: username, password: password})
  }

  register(newUser: User) {
    return this.http.post(`${this.baseUrl}/register`, newUser)
  }

  getAllUser(): Observable<User[]> {
    return this.http.get<User[]>(this.baseUrl)
  }

  deleteUser(id: number) {
    return this.http.delete(`${this.baseUrl}/${id}`)
  }

  changeRoleOfUser(id: number):Observable<User> {
    return this.http.patch<User>(`${this.baseUrl}/${id}`, {})
  }

  getAllWorker(): Observable<User[]> {
    return this.http.get<User[]>(`${this.baseUrl}/worker`)
  }

   updateUser(id: number, requestBody: {username: string, firstName: string, lastName: string, email: string}): Observable<User> {
    return this.http.put<User>(`${this.baseUrl}/${id}`, requestBody)
  }

   getVerificationCode(email: string) {
    return this.http.get(`${this.baseUrl}/getVerificationCode`, { params: new HttpParams().set("email", email) })
  }

  checkVerificationCode(userVCode: string, email: string): Observable<boolean> {
    return this.http.post<boolean>(`${this.baseUrl}/checkVerificationCode`, { vCode: userVCode, email: email })
  }

  passwordReset(email: string, newPassword: string, vCode: string) {
    return this.http.patch(`${this.baseUrl}/passwordReset`, { email: email, newPassword: newPassword, vCode: vCode })
  }
}
