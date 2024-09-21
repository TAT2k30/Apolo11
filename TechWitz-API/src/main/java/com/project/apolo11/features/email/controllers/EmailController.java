package com.project.apolo11.features.email.controllers;

import com.project.apolo11.common.ResultResponse;
import com.project.apolo11.features.email.services.EmailService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Random;


@RestController
@RequestMapping("/api/v1/email")
public class EmailController {

    private final EmailService emailService;

    public EmailController(EmailService emailService) {
        this.emailService = emailService;
    }

    @PostMapping("/send-6-digit-code/{email}/{name}")
    public ResponseEntity<ResultResponse<?>> send6DigitCode(
            @PathVariable(name = "email") String email,
            @PathVariable(name = "name") String name
    ) {
        if (email == null) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ResultResponse.<Boolean>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(false)
                            .message("Send 6 digit code failed : Email is missing")
                            .status(HttpStatus.INTERNAL_SERVER_ERROR)
                            .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
                            .build());
        }
        try {
            Random random = new Random();
            StringBuilder code = new StringBuilder();
            for (int i = 0; i < 6; i++) {
                code.append(random.nextInt(10));
            }
            emailService.sendHtmlEmail(name, email, code.toString());
            return ResponseEntity.ok(
                    ResultResponse.<Boolean>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(true)
                            .message("Send 6 digit code successfully")
                            .status(HttpStatus.OK)
                            .statusCode(HttpStatus.OK.value())
                            .build());
        } catch (Exception ex) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ResultResponse.<Boolean>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(false)
                            .message("Send 6 digit code failed : " + ex.getMessage())
                            .status(HttpStatus.INTERNAL_SERVER_ERROR)
                            .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
                            .build());
        }

    }

}
