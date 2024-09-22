package com.project.apolo11.features.account.controllers;


import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;
import com.project.apolo11.common.ResultResponse;
import com.project.apolo11.features.account.domains.dtos.request.CreateAccountRequest;
import com.project.apolo11.features.account.domains.entities.Account;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/api/v1/admin")
public class AdminController {

    @PostMapping("/create-account")
    public ResponseEntity<ResultResponse<?>> createAccount(@RequestBody CreateAccountRequest createAccountRequest) {
        try {
            Firestore dbFireStore = FirestoreClient.getFirestore();

            Account account = new Account();
            account.setUserName(createAccountRequest.getUserName());
            account.setPassword(createAccountRequest.getPassword());
            account.setAvatarUrl(createAccountRequest.getAvatarUrl());
            account.setGender(createAccountRequest.getGender());
            account.setEmail(createAccountRequest.getEmail());


            // Lưu vào Firestore
            ApiFuture<WriteResult> collectionApiFuture = dbFireStore.collection("account").document(account.getEmail()).set(account);

            // Đợi kết quả để đảm bảo ghi dữ liệu thành công
            WriteResult writeResult = collectionApiFuture.get();
            System.out.println("Account saved at: " + writeResult.getUpdateTime());

            return ResponseEntity.ok(
                    ResultResponse.<Account>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(account)
                            .message("Create account successfully")
                            .status(HttpStatus.OK)
                            .statusCode(HttpStatus.OK.value())
                            .build()
            );
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ResultResponse.<Boolean>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(false)
                            .message("Create account failed: " + e.getMessage())
                            .status(HttpStatus.INTERNAL_SERVER_ERROR)
                            .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
                            .build());
        }
    }
}

