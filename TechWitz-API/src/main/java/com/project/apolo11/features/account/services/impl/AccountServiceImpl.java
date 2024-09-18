package com.project.apolo11.features.account.services.impl;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;
import com.project.apolo11.features.account.domains.dtos.request.LoginRequest;
import com.project.apolo11.features.account.domains.dtos.request.RegisterRequest;
import com.project.apolo11.features.account.domains.entities.Account;
import com.project.apolo11.features.account.services.AccountService;
import com.project.apolo11.features.account.utils.AccountUtils;
import com.project.apolo11.features.account.utils.PasswordUtils;
import com.project.apolo11.features.account.utils.Role;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

@Service
public class AccountServiceImpl implements AccountService {
    private final AccountUtils accountUtils;
    private final PasswordUtils passwordUtils;
    public AccountServiceImpl(AccountUtils accountUtils, PasswordUtils passwordUtils) {
        this.accountUtils = accountUtils;
        this.passwordUtils = passwordUtils;
    }

    @Override
    public Account login(LoginRequest loginRequest) {
        Firestore dbFireStore = FirestoreClient.getFirestore();

        // Kiểm tra có document với Email này tồn tại không
        CompletableFuture<DocumentSnapshot> future = CompletableFuture.supplyAsync(() -> {
            try {
                DocumentReference docRef = dbFireStore.collection("account").document(loginRequest.getEmail());
                return docRef.get().get();
            } catch (InterruptedException | ExecutionException e) {
                throw new RuntimeException("Failed to retrieve account", e);
            }
        });

        try {
            DocumentSnapshot document = future.join();

            if (document.exists()) {
                Account accountFromFirestore = document.toObject(Account.class);

                // So sánh mật khẩu
                boolean isPasswordMatch = passwordUtils.matches(loginRequest.getPassword(), accountFromFirestore.getPassword());

                if (isPasswordMatch) {
                    return accountFromFirestore;
                } else {
                    throw new RuntimeException("Invalid password");
                }
            } else {
                throw new RuntimeException("No account found with email: " + loginRequest.getEmail());
            }
        } catch (Exception e) {
            throw new RuntimeException("Login failed: " + e.getMessage(), e);
        }
    }


    @Override
    public Account register(RegisterRequest registerRequest) {
        Firestore dbFireStore = FirestoreClient.getFirestore();

        DocumentReference docRef = dbFireStore.collection("account").document(registerRequest.getEmail());

        // Kiểm tra xem tài liệu với email đã tồn tại chưa
        CompletableFuture<DocumentSnapshot> future = CompletableFuture.supplyAsync(() -> {
            try {
                return docRef.get().get();
            } catch (InterruptedException | ExecutionException e) {
                throw new RuntimeException("Failed to check if email exists", e);
            }
        });

        try {
            DocumentSnapshot document = future.join();

            if (document.exists()) {
                throw new RuntimeException("Email has been registered");
            }

            Account accountFromFireBase = new Account();
            accountFromFireBase.setPassword(passwordUtils.encodePassword(registerRequest.getPassword()));
            accountFromFireBase.setId(UUID.randomUUID().toString());
            accountFromFireBase.setAvatarUrl(accountUtils.getMaleAvatar()); // Đặt avatar mặc định
            accountFromFireBase.setEmail(registerRequest.getEmail());
            accountFromFireBase.setUserName(registerRequest.getUserName());
            accountFromFireBase.setGender(registerRequest.getGender());
            accountFromFireBase.setPhoneNumber(registerRequest.getPhoneNumber());
            accountFromFireBase.setRoles(Collections.singletonList(Role.USER_ID.getValue())); // Mặc định USER khi register.

            CompletableFuture<WriteResult> writeFuture = CompletableFuture.supplyAsync(() -> {
                try {
                    return dbFireStore.collection("account")
                            .document(registerRequest.getEmail())
                            .set(accountFromFireBase).get();
                } catch (InterruptedException | ExecutionException e) {
                    throw new RuntimeException("Failed to register account", e);
                }
            });

            writeFuture.join();
            return accountFromFireBase;

        } catch (Exception e) {
            // Log lỗi chi tiết
            System.err.println("Error occurred during account registration: " + e.getMessage());
            throw new RuntimeException("Register account failed", e);
        }
    }


    @Override
    public void logout() {

    }

    @Override
    public void changePassword() {

    }

    @Override
    public void forgotPassword() {

    }

    @Override
    public void resetPassword() {

    }

    @Override
    public void verifyEmail() {

    }

    @Override
    public Account getAccountById(String id) {
        return null;
    }
}
