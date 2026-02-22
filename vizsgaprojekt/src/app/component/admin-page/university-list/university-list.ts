import { Component, inject, OnInit } from '@angular/core';
import { Faculty } from '../../../models/Faculty.model';
import { university } from '../../../models/University.model';
import { FacultyService } from '../../../service/faculty-service';
import { UniversityService } from '../../../service/university-service';
import { UniversityCard } from './university-card/university-card';
import { UniversityCreator } from './university-create/university-creator';

@Component({
  selector: 'app-university-list',
  imports: [UniversityCard, UniversityCreator],
  templateUrl: './university-list.html',
  styleUrl: './university-list.scss',
})
export class UniversityList implements OnInit{
  universityService = inject(UniversityService)
  facultyService = inject(FacultyService)
  universities: university[] = []
  faculties: Faculty[] = []
  showCreatorForm: boolean = false

  ngOnInit(): void {
    this.universityService.getAllUniversity().subscribe({
      next: response => this.universities = response
    })

    this.facultyService.getAllFaculty().subscribe({
      next: response => this.faculties = response
    })
  }

  deleteUniversity(id: number, index: number) {
    this.universityService.deleteUniversity(id).subscribe({
      next: response => {
        this.universities.splice(index, 1)
      }
    })
  }

  updateUniversity(formValue: {name: string, description: string, address: string, googleMapsLink: string, faculties: number[], pageLink: string,}, id: number, index: number) {
    this.universityService.updateUniversity(
      new university(id, formValue.name, formValue.description, formValue.address, formValue.googleMapsLink, formValue.pageLink,
        formValue.faculties.map((id) => this.faculties.find(f => f.id == id)!)
      )
    ).subscribe({
      next: response => {
        this.universities[index] = response
      }
    })
  }

  addUniversity(formValue: {name: string, description: string, address: string, googleMapsLink: string, faculties: number[], pageLink: string}) {
    this.universityService.addUniversity(
      new university(null, formValue.name, formValue.description, formValue.address, formValue.googleMapsLink, formValue.pageLink,
        formValue.faculties.map((id) => this.faculties.find(f => f.id == id)!)
      )
    ).subscribe({
      next: response => {
        this.universities.push(response)
      }, complete: () => {
        this.showCreatorForm = false
      }
    })
  }
}