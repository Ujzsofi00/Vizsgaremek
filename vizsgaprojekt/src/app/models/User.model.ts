import { Appointment } from "./Appointment.model";
import { Role } from "./role.model";

export class User {
  constructor(
    public id: number | null,
    public username: string,
    public firstName: string,
    public lastName: string,
    public email: string,
    public password: string,
    public role?: Role,
    public bookedAppointments: Appointment[] = [],
    public workAppointment: Appointment[] = [],
    public isDeleted: boolean = false,
    public deletedAt: Date|null = null,
  ) { }
}
