import { Routes } from '@angular/router';
import { Home } from './component/home/home';
import { Login } from './component/login/login';
import { AppointmentSelector } from './component/appointment-selector/appointment-selector'; 
import { UniversitySearch } from './component/university-search/university-search'; 
import { AdminPage } from './component/admin-page/admin-page'; 
import { NotFound } from './component/not-found/not-found';
import { Register } from './component/register/register';
import { Unauthorized } from './component/unauthorized/unauthorized';
import { UniversityList } from './component/admin-page/university-list/university-list';
import { UserList } from './component/admin-page/user-list/user-list';
import { EventManagerPage } from './component/admin-page/event-manager-page/event-manager-page';
import { AuthGuard } from './routeGuard/authGuard';
import { RoleAuthGuard } from './routeGuard/roleAuthGuard';
import { ProfilPage } from './component/profil-page/profil-page';


export const routes: Routes = [
  { path: "homePage", component: Home },
  { path: "", pathMatch: "full", redirectTo: "homePage" },
  { path: "login", component: Login },
  { path: "register", component: Register },
  { path: "appointmentReservation", component: AppointmentSelector, canMatch: [AuthGuard] },
  { path: "universitySearch", component: UniversitySearch },
  { path: "adminPage", component: AdminPage, canMatch: [RoleAuthGuard], data: {roles: ["ROLE_admin"]}},
  { path: "universities", component: UniversityList, canMatch: [RoleAuthGuard], data: {roles: ["ROLE_admin"]} },
  { path: "users", component: UserList, canMatch: [RoleAuthGuard], data: {roles: ["ROLE_admin"]} },
  { path: "eventManager", component: EventManagerPage, canMatch: [RoleAuthGuard], data: {roles: ["ROLE_admin", "ROLE_worker"]} },
  { path: 'profilPage', component: ProfilPage, canMatch: [AuthGuard] },
  { path: "unauthorized", component: Unauthorized },
  { path: "**", component: NotFound }
];