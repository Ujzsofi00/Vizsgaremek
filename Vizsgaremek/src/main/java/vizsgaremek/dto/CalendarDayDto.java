package vizsgaremek.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDate;

@Data
@AllArgsConstructor
public class CalendarDayDto {

    private LocalDate date;

    private boolean isToday;
    private boolean isFull;
    private boolean isBookable;
}
