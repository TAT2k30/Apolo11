package com.project.apolo11.features.account.services.impl;

import com.google.api.core.ApiFuture;
import com.google.cloud.Timestamp;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import com.project.apolo11.features.account.domains.dtos.request.LoginRequest;
import com.project.apolo11.features.account.domains.dtos.request.RegisterRequest;
import com.project.apolo11.features.account.domains.dtos.request.UpdateAccountRequest;
import com.project.apolo11.features.account.domains.entities.Account;
import com.project.apolo11.features.account.domains.entities.Token;
import com.project.apolo11.features.account.services.AccountService;
import com.project.apolo11.features.account.services.TokenService;
import com.project.apolo11.features.account.utils.AccountUtils;
import com.project.apolo11.features.account.utils.PasswordUtils;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

@Service
public class AccountServiceImpl implements AccountService {
    private final AccountUtils accountUtils;
    private final PasswordUtils passwordUtils;
    private final TokenServiceImpl tokenService;

    public AccountServiceImpl(AccountUtils accountUtils, PasswordUtils passwordUtils, TokenServiceImpl tokenService) {
        this.accountUtils = accountUtils;
        this.passwordUtils = passwordUtils;
        this.tokenService = tokenService;
    }

    @Override
    public Account login(LoginRequest loginRequest) {
        Firestore dbFireStore = FirestoreClient.getFirestore();
        DocumentReference accountDocRef = dbFireStore.collection("account").document(loginRequest.getEmail());
        try {
            DocumentSnapshot document = accountDocRef.get().get();

            if (document.exists()) {
                Account accountFromFirestore = document.toObject(Account.class);

                boolean isPasswordMatch = passwordUtils.matches(loginRequest.getPassword(), accountFromFirestore.getPassword());

                if (isPasswordMatch) {
                    String token = accountUtils.generateAccountPrivateToken(accountFromFirestore);
                    DocumentReference tokenDocRef = dbFireStore.collection("accessToken").document(token);
                    ApiFuture<DocumentSnapshot> future = tokenDocRef.get();
                    DocumentSnapshot checkToken = future.get();
                    if (checkToken.exists()) {
                        throw new RuntimeException("Account is already logged in");
                    } else {
                        tokenService.saveTokenToFireStore(token);
                        return accountFromFirestore;
                    }
                } else {
                    throw new RuntimeException("Invalid password");
                }
            } else {
                throw new RuntimeException("No account found with email: " + loginRequest.getEmail());
            }
        } catch (InterruptedException | ExecutionException e) {
            Thread.currentThread().interrupt();
            throw new RuntimeException("Failed to retrieve account: " + e.getMessage(), e);
        }
    }


    @Override
    public Account register(RegisterRequest registerRequest) {
        Firestore dbFireStore = FirestoreClient.getFirestore();

        // Tạo đối tượng Account mới để lưu
        Account accountSaveToFireBase = new Account();
        accountSaveToFireBase.setId(UUID.randomUUID().toString());
        accountSaveToFireBase.setUserName(registerRequest.getUserName());
        accountSaveToFireBase.setEmail(registerRequest.getEmail());
        accountSaveToFireBase.setGender(registerRequest.getGender());
        accountSaveToFireBase.setPhoneNumber(registerRequest.getPhoneNumber());
        accountSaveToFireBase.setPassword(passwordUtils.encodePassword(registerRequest.getPassword()));
        accountSaveToFireBase.setRole("USER");

        String avatarUrl = accountUtils.getMaleAvatar();
        if ("female".equalsIgnoreCase(registerRequest.getGender())) {
            avatarUrl = accountUtils.getFemaleAvatar();
        }
        accountSaveToFireBase.setAvatarUrl(avatarUrl);

        accountSaveToFireBase.setCreatedAt(Instant.now());
        accountSaveToFireBase.setUpdatedAt(Instant.now());

        // Sử dụng email làm document ID để kiểm tra tài khoản
        DocumentReference docRef = dbFireStore.collection("account").document(accountSaveToFireBase.getEmail());

        return CompletableFuture.supplyAsync(() -> {
            try {
                // Kiểm tra nếu tài khoản với email này đã tồn tại
                DocumentSnapshot document = docRef.get().get();
                if (document.exists()) {
                    throw new RuntimeException("Email has already been registered");
                }
                ApiFuture<WriteResult> collectionApiFuture = docRef.set(accountSaveToFireBase);
                collectionApiFuture.get();
                return accountSaveToFireBase;
            } catch (InterruptedException | ExecutionException e) {
                throw new RuntimeException("Failed to register account: " + e.getMessage());
            }
        }).exceptionally(ex -> {
            System.err.println("Error occurred during account registration: " + ex.getMessage());
            throw new RuntimeException("Register account failed", ex);
        }).join();
    }


    @Override
    public void logout(String privateAccountToken) {
        Firestore dbFireStore = FirestoreClient.getFirestore();
        try {
            DocumentReference docRef = dbFireStore.collection("accessToken").document(privateAccountToken);

            DocumentSnapshot document = docRef.get().get();
            if (document.exists()) {
                ApiFuture<WriteResult> collectionApiFuture = docRef.delete();
                collectionApiFuture.get();
            } else {
                throw new RuntimeException("Invalid token header");
            }
        } catch (Exception e) {
            System.err.println("Error occurred during account registration: " + e.getMessage());
            throw new RuntimeException("Logout failed" + e.getMessage());
        }
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
        Firestore dbFireStore = FirestoreClient.getFirestore();
        DocumentReference docRef = dbFireStore.collection("account").document(id);

        try {
            DocumentSnapshot document = docRef.get().get();
            if (document.exists()) {
                Account account = document.toObject(Account.class);
                if (account != null) {
                    account.setCreatedAt(Instant.ofEpochMilli(account.getCreatedAt().toEpochMilli()));
                    account.setUpdatedAt(Instant.ofEpochMilli(account.getUpdatedAt().toEpochMilli()));
                }
                return account;
            } else {
                throw new RuntimeException("No account found with id: " + id);
            }
        } catch (InterruptedException | ExecutionException e) {
            throw new RuntimeException("Failed to retrieve account: " + e.getMessage(), e);
        }
    }

    @Override
    public Account updateAccount(UpdateAccountRequest updateAccountRequest, String avatarUrl, String email) throws ExecutionException, InterruptedException {
        Firestore dbFireStore = FirestoreClient.getFirestore();

        // Lấy tài liệu hiện tại từ Firestore theo email
        DocumentReference docRef = dbFireStore.collection("account").document(email);
        ApiFuture<DocumentSnapshot> futureDoc = docRef.get();
        DocumentSnapshot document = futureDoc.get();

        if (document.exists()) {
            Account accountToUpdate = document.toObject(Account.class);
            assert accountToUpdate != null;
            accountToUpdate.setUserName(updateAccountRequest.getUserName());
            accountToUpdate.setAvatarUrl(avatarUrl);
            accountToUpdate.setUpdatedAt(Instant.now());
            accountToUpdate.setGender(updateAccountRequest.getGender());
            ApiFuture<WriteResult> future = docRef.set(accountToUpdate);
            future.get();

            return accountToUpdate;
        } else {
            throw new IllegalStateException("Tài khoản với email này không tồn tại.");
        }
    }


}
