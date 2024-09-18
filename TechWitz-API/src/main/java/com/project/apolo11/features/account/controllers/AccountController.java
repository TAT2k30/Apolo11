package com.project.apolo11.features.account.controllers;

import com.project.apolo11.common.ResultResponse;
import com.project.apolo11.features.account.domains.dtos.request.LoginRequest;
import com.project.apolo11.features.account.domains.dtos.request.RegisterRequest;
import com.project.apolo11.features.account.domains.entities.Account;
import com.project.apolo11.features.account.services.AccountService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Set;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("/api/v1/account")
public class AccountController {
    private final AccountService accountService;

    public AccountController(
            AccountService accountService
    ) {
        this.accountService = accountService;
    }

    @PostMapping("/login")
    public ResponseEntity<ResultResponse<?>> login(
            @RequestBody LoginRequest loginRequest
    ) throws InterruptedException, ExecutionException {
        try{
            Account account = accountService.login(loginRequest);
            return ResponseEntity.ok(
                    ResultResponse.<Account>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(account)
                            .message("Account login successfully.")
                            .status(HttpStatus.OK)
                            .statusCode(HttpStatus.OK.value())
                            .build()
            );
        }catch(Exception e){
            return ResponseEntity.ok(
                    ResultResponse.<Boolean>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(false)
                            .message(e.getMessage())
                            .status(HttpStatus.EXPECTATION_FAILED)
                            .statusCode(HttpStatus.EXPECTATION_FAILED.value())
                            .build()
            );
        }

    }

    @PostMapping("/register")
    public ResponseEntity<ResultResponse<?>> register(
            @RequestBody RegisterRequest registerRequest
    ) throws InterruptedException, ExecutionException {
        try{
            Account account = accountService.register(registerRequest);
            return ResponseEntity.ok(
                    ResultResponse.<Account>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(account)
                            .message("Account registered successfully.")
                            .status(HttpStatus.OK)
                            .statusCode(HttpStatus.OK.value())
                            .build()
            );
        }catch(Exception e){
            return ResponseEntity.ok(
                    ResultResponse.<Boolean>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(false)
                            .message(e.getMessage())
                            .status(HttpStatus.EXPECTATION_FAILED)
                            .statusCode(HttpStatus.EXPECTATION_FAILED.value())
                            .build()
            );
        }

    }

//    @GetMapping("/get-account-by-id/{documentId}")
//    public ResponseEntity<ResultResponse<?>> getAccountById(
//            @RequestParam String documentId
//    ) {
//        try{
//            Account account = accountService.getAccountById(documentId);
//            return ResponseEntity.ok(
//                    ResultResponse.<Boolean>builder()
//                            .timeStamp(LocalDateTime.now().toString())
//                            .body(true)
//                            .message("Account registered successfully.")
//                            .status(HttpStatus.OK)
//                            .statusCode(HttpStatus.OK.value())
//                            .build()
//            );
//        }catch(Exception e){
//
//        }
//    }
}
