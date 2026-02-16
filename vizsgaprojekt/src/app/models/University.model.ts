import { Faculty } from "./Faculty.model";

export class university {
  constructor(
    public id: number | null,
    public name: string,
    public description: string,
    public address: string,
    public googleMapsLink: string,
    public faculties: Faculty[],
    public isDeleted: boolean = false
  ) {}
}
