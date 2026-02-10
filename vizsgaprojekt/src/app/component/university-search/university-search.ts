import { Component, inject } from '@angular/core';
import { UniversityService } from '../../service/university-service';
import { university } from '../../models/University.model';

@Component({
  selector: 'app-university-search',
  imports: [],
  templateUrl: './university-search.html',
  styleUrl: './university-search.scss',
})
export class UniversitySearch {
  universityService = inject(UniversityService)
  selectedUniversity: university | null = null;
  universities: university[] = []

  getUniversityByName(name: string) {
    if (name != "") {
      this.universityService.getUniversityByName(name).subscribe({
        next: response => {
          this.universities = response
        }
      })
    } else {
      this.universities = []
    }
  }

  selectUniversity(selectedUniversity: university) {
    this.selectedUniversity = selectedUniversity;
    this.universities = []
  }
}