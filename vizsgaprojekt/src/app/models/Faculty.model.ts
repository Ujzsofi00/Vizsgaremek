import { university } from "./University.model";

export class Faculty {
  constructor(
    public id: number,
    public name: string,
    public description: string,
    public university: university[]
  ) { }
}
