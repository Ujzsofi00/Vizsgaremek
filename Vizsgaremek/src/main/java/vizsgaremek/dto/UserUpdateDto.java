package vizsgaremek.dto;

public record UserUpdateDto(
        String username,
        String firstName,
        String lastName,
        String email
) {
}
