import { Role } from "./role.model";

export class User {
  constructor(
    public id: number | null,
    public userName: string,
    public firstName: string,
    public lastName: string,
    public email: string,
    public password: string,
    public role?: Role
  ) { }
}