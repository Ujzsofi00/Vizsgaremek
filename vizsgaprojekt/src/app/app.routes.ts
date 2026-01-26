import { Routes } from '@angular/router';
import { Home } from './component/home/home';
import { Login } from './component/login/login';
import { AppointmentSelector } from './component/appointment-selector/appointment-selector'; 
import { UniversitySearch } from './component/university-search/university-search'; 
import { AdminPage } from './component/admin-page/admin-page'; 
import { NotFound } from './component/not-found/not-found';
import { Register } from './component/register/register'; 

export const routes: Routes = [
  { path: "homePage", component: Home, },
  { path: "", pathMatch: "full", redirectTo: "homePage" },
  { path: "login", component: Login },
  { path: "register", component: Register },
  { path: "appointmentReservation", component: AppointmentSelector },
  { path: "universitySearch", component: UniversitySearch },
  { path: "adminPage", component: AdminPage },
  { path: "**", component: NotFound }
];