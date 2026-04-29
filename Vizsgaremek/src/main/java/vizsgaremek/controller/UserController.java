package vizsgaremek.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import tools.jackson.databind.JsonNode;
import vizsgaremek.dto.UserUpdateDto;
import vizsgaremek.entity.Users;
import vizsgaremek.service.UserService;

@RequiredArgsConstructor
@RestController
@RequestMapping("/user")
public class UserController {
    private final UserService userService;

    @PostMapping("/register")
    public ResponseEntity<Object> registerUser(@RequestBody Users user) {
        return userService.register(user);
    }

    @PostMapping("/login")
    public ResponseEntity<Object> login(@RequestBody JsonNode requestBody) {
        return userService.login(requestBody.get("username").asString(null), requestBody.get("password").asString(null));
    }

    @GetMapping("")
    public ResponseEntity<Object> getAllUser() {
        return userService.getAllUser();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Object> deleteUser(@PathVariable("id") Integer id) {
        return userService.deleteUser(id);
    }

    @PatchMapping("/{id}")
    public ResponseEntity<Object> changeRoleOfUser(@PathVariable("id") Integer id) {
        return userService.changeRoleOfUser(id);
    }

    @GetMapping("/worker")
    public ResponseEntity<Object> getAllWorker() {
        return userService.getAllWorker();
    }

    @PutMapping("/{id}")
    public ResponseEntity<Object> updateUser(@PathVariable Integer id, @RequestBody UserUpdateDto updatedUser) {
        return userService.updateUser(id, updatedUser);
    }

    //passwordReset:
    @GetMapping("/getVerificationCode")
    public ResponseEntity<Object> getVerificationCode(@RequestParam("email") String email) {
        return userService.getVerificationCode(email);
    }

    @PostMapping("/checkVerificationCode")
    public ResponseEntity<Object> checkVerificationCode(@RequestBody JsonNode body) {
        return userService.checkVerificationCode(body.get("vCode").asText(null), body.get("email").asText(null));
    }

    @PatchMapping("/passwordReset")
    public ResponseEntity<Object> updatePassword(@RequestBody JsonNode body) {
        return userService.updatePassword(body.get("email").asText(), body.get("newPassword").asText());
    }
}
