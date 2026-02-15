import { ChangeDetectionStrategy, Component, inject, OnInit, output } from '@angular/core';
import { FacultyService } from '../../../../service/faculty-service';
import { Faculty } from '../../../../models/Faculty.model';
import { FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSelectModule } from '@angular/material/select';

@Component({
  selector: 'app-university-create',
  imports: [ReactiveFormsModule,MatFormFieldModule, MatSelectModule, FormsModule],
  templateUrl: './university-create.html',
  styleUrl: './university-create.scss',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class UniversityCreate implements OnInit{
  private facultyService = inject(FacultyService)
  faculties: Faculty[] = []
  createForm!: FormGroup
  create = output<{name: string, description: string, address: string, googleMapsLink: string, faculties: number[]}>()
  close = output()

  ngOnInit(): void {
    this.createForm = new FormGroup({
      name: new FormControl("", [Validators.required]),
      description: new FormControl("", [Validators.required]),
      address: new FormControl("", [Validators.required]),
      googleMapsLink: new FormControl("", [Validators.required]),
      faculties: new FormControl("", [Validators.required])
    })

    this.facultyService.getAllFaculty().subscribe({
      next: response => this.faculties = response
    })
  }

  sendCreate() {
    this.create.emit(this.createForm.value)
  }
}