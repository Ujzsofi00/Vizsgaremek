import { ChangeDetectionStrategy, Component, inject, input, OnInit, output, signal } from '@angular/core';
import { MatExpansionModule } from '@angular/material/expansion';
import { university } from '../../../../models/University.model';
import { FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSelectModule } from '@angular/material/select';
import { FacultyService } from '../../../../service/faculty-service';
import { Faculty } from '../../../../models/Faculty.model';

@Component({
  selector: 'app-university-card',
  imports: [MatExpansionModule, ReactiveFormsModule, MatFormFieldModule, MatSelectModule, FormsModule],
  templateUrl: './university-card.html',
  styleUrl: './university-card.scss',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class UniversityCard implements OnInit {
  private facultyService = inject(FacultyService)
  faculties: Faculty[] = []
  univeristy = input.required<university>()
  panelOpenState = signal(false);
  delete = output()
  isEdit: boolean = false
  updateForm!: FormGroup
  update = output<{name: string, description: string, address: string, googleMapsLink: string, faculties: number[], pageLink: string}>()

  ngOnInit(): void {
    this.updateForm = new FormGroup({
      name: new FormControl(this.univeristy().name, [Validators.required]),
      description: new FormControl(this.univeristy().description, [Validators.required]),
      address: new FormControl(this.univeristy().address, [Validators.required]),
      googleMapsLink: new FormControl(this.univeristy().googleMapsLink, [Validators.required]),
      faculties: new FormControl(this.univeristy().faculties.map(f=>f.id), [Validators.required]),
      pageLink: new FormControl(this.univeristy().pageLink, [Validators.required]),
    })

    this.facultyService.getAllFaculty().subscribe({
      next: response => this.faculties = response
    })
  }

  deleteUniversity() {
    this.delete.emit()
  }

  sendUpdate() {
    if (this.isEdit) {
      this.update.emit(this.updateForm.value)
    }
    this.isEdit = !this.isEdit
  }
}
