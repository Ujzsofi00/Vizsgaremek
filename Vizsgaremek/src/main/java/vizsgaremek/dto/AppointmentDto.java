package vizsgaremek.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class AppointmentDto {
    private String title;
    private String date;
    private String start;
    private String end;
    private Boolean isOnline;
    private Integer capacity;
    private Integer workerId;
}
