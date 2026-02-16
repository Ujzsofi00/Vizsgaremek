import { User } from "./User.model";

export class Appointment {
  constructor(
    public id: number,
    public date: Date,
    public start: Date,
    public end: Date,
    public capacity: number,
    public isOnline: boolean,
    public isFull: boolean,
    public isDeleted: boolean,
    public reserverUsers: User[],
    public worker: User
  ) { }
}
