package com.project.apolo11.features.account.controllers;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;
import com.project.apolo11.common.ResultResponse;
import com.project.apolo11.features.account.domains.dtos.request.LoginRequest;
import com.project.apolo11.features.account.domains.dtos.request.RegisterRequest;
import com.project.apolo11.features.account.domains.dtos.request.UpdateAccountRequest;
import com.project.apolo11.features.account.domains.dtos.request.UpdateAccountWithMultiplePathFileRequest;
import com.project.apolo11.features.account.domains.entities.Account;
import com.project.apolo11.features.account.services.AccountService;
import com.project.apolo11.features.account.utils.AccountUtils;
import com.project.apolo11.utils.FileService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("/api/v1/account")
public class AccountController {
    private final AccountService accountService;
    private final FileService fileService;
    private final AccountUtils accountUtils;

    public AccountController(
            AccountService accountService,
            AccountUtils accountUtils,
            FileService fileService
    ) {
        this.accountService = accountService;
        this.fileService = fileService;
        this.accountUtils = accountUtils;
    }

    @PostMapping("/login")
    public ResponseEntity<ResultResponse<?>> login(
            @RequestBody LoginRequest loginRequest
    ) throws InterruptedException, ExecutionException {
        try {
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
        } catch (Exception e) {
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
        try {
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
        } catch (Exception e) {
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

    @GetMapping("/get-account-by-id/{documentId}")
    public ResponseEntity<ResultResponse<?>> getAccountById(
            @PathVariable String documentId
    ) {
        try {
            Account account = accountService.getAccountById(documentId);
            return ResponseEntity.ok(
                    ResultResponse.<Account>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(account)
                            .message("Get account with id successFully.")
                            .status(HttpStatus.OK)
                            .statusCode(HttpStatus.OK.value())
                            .build()
            );
        } catch (Exception e) {
            return ResponseEntity.ok(
                    ResultResponse.<Boolean>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(true)
                            .message("Account registered successfully.")
                            .status(HttpStatus.OK)
                            .statusCode(HttpStatus.OK.value())
                            .build()
            );
        }
    }

    @PostMapping("/create-account")
    public ResponseEntity<ResultResponse<?>> createAccount(
            @RequestBody Account account
    ) {
        Firestore dbFireStore = FirestoreClient.getFirestore();
        DocumentReference docRef = dbFireStore.collection("account").document();

        Map<String, Object> data = new HashMap<>();
        data.put("id", docRef.getId());
        data.put("userName", account.getUserName());
        data.put("password", account.getPassword());
        data.put("avatarUrl", account.getAvatarUrl());
        data.put("gender", account.getGender());
        data.put("email", account.getEmail());
        data.put("createdAt", account.getCreatedAt());
        data.put("updatedAt", account.getUpdatedAt());
        data.put("role", "USER");

        try {
            ApiFuture<WriteResult> result = docRef.set(data);
            result.get();

            ResultResponse<Account> response = ResultResponse.<Account>builder()
                    .timeStamp(LocalDateTime.now().toString())
                    .body(account)
                    .message("Account created successfully.")
                    .status(HttpStatus.CREATED)
                    .statusCode(HttpStatus.CREATED.value())
                    .build();
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (InterruptedException | ExecutionException e) {
            return ResponseEntity.ok(
                    ResultResponse.<Boolean>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(true)
                            .message("Account registered successfully.")
                            .status(HttpStatus.OK)
                            .statusCode(HttpStatus.OK.value())
                            .build()
            );
        }
    }

    @PostMapping("/update-account")
    public ResponseEntity<ResultResponse<?>> updateAccount(
            @RequestHeader("Account-Private-Token") String token,
            @ModelAttribute UpdateAccountRequest updateAccountRequest
    ) {
        if (token == null) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ResultResponse.<Boolean>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(false)
                            .message("Update account failed : Token is missing")
                            .status(HttpStatus.INTERNAL_SERVER_ERROR)
                            .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
                            .build());
        }
        try {
            String avatarUrl = null;
            if (updateAccountRequest.getFile() != null && !updateAccountRequest.getFile().isEmpty()) {
                avatarUrl = fileService.upload("upload/",updateAccountRequest.getFile());
            }

            Account accountUpdated = accountService.updateAccount(
                    updateAccountRequest,
                    avatarUrl,
                    accountUtils.getEmailByToken(token)
            );

            return ResponseEntity.ok(
                    ResultResponse.<Account>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(accountUpdated)
                            .message("Account updated successfully.")
                            .status(HttpStatus.OK)
                            .statusCode(HttpStatus.OK.value())
                            .build()
            );
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ResultResponse.<Boolean>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(false)
                            .message("Update account failed : " + e.getMessage())
                            .status(HttpStatus.INTERNAL_SERVER_ERROR)
                            .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
                            .build());
        }
    }


    @PostMapping("/logout")
    public ResponseEntity<ResultResponse<?>> logout(
            @RequestHeader("Account-Private-Token") String accountPrivateToken
    ) {
        if (accountPrivateToken == null) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ResultResponse.<Boolean>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(false)
                            .message("Logout failed, please try again later")
                            .status(HttpStatus.INTERNAL_SERVER_ERROR)
                            .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
                            .build());
        } else {
            try {
                accountService.logout(accountPrivateToken);
                return ResponseEntity.ok(
                        ResultResponse.<Boolean>builder()
                                .timeStamp(LocalDateTime.now().toString())
                                .body(true)
                                .message("Logout successfully")
                                .status(HttpStatus.OK)
                                .statusCode(HttpStatus.OK.value())
                                .build()
                );
            } catch (Exception e) {
                System.out.print("Error logout: " + e.getMessage());
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body(ResultResponse.<Boolean>builder()
                                .timeStamp(LocalDateTime.now().toString())
                                .body(false)
                                .message("Logout failed, please try again later")
                                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                                .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
                                .build());
            }
        }
    }

    @GetMapping("/get-all-account")
    public ResponseEntity<ResultResponse<?>> getAllAccount(){
        return ResponseEntity.ok(
                ResultResponse.<Boolean>builder()
                        .timeStamp(LocalDateTime.now().toString())
                        .body(true)
                        .message("get all account ok")
                        .status(HttpStatus.OK)
                        .statusCode(HttpStatus.OK.value())
                        .build()
        );
    }
}

