import { User } from "./User.model";

export class Appointment {
  constructor(
    public id: number | null,
    public title: string,
    public date: Date,
    public start: Date | string,
    public end: Date | string,
    public capacity: number,
    public worker: User,
    public isOnline: boolean,
    public isFull: boolean,
    public isDeleted: boolean,
    public reserverUsers: User[],
    public deletedAt: Date|null = null
  ) { }
}