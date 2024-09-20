package com.project.apolo11.features.account.services.impl;

import com.google.api.core.ApiFuture;
import com.google.cloud.Timestamp;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;
import com.project.apolo11.features.account.domains.entities.Token;
import com.project.apolo11.features.account.services.TokenService;
import com.project.apolo11.features.account.utils.AccountUtils;
import com.project.apolo11.features.account.utils.PasswordUtils;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutionException;

@Service
public class TokenServiceImpl implements TokenService {
    private final PasswordUtils passwordUtils;

    public TokenServiceImpl(PasswordUtils passwordUtils) {
        this.passwordUtils = passwordUtils;
    }

    @Override
    public String checkTokenRole(Token token, String rawPassword) {
        String[] tokenParts = token.getToken().split("-");
        if(tokenParts.length == 3) {
            String role = tokenParts[1];
            return role;
        }else{
            throw new RuntimeException("Token format is incorrect");
        }
    }
    @Override
    public void saveTokenToFireStore(String token) {
        Firestore dbFireStore = FirestoreClient.getFirestore();

        DocumentReference tokenDocRef = dbFireStore.collection("accessToken").document(token);

        Token tokenData = new Token();
        tokenData.setToken(token);
        tokenData.setCreatedAt(Timestamp.now());
        tokenData.setUpdatedAt(Timestamp.now());

        ApiFuture<WriteResult> writeResult = tokenDocRef.set(tokenData);

        try {
            writeResult.get();
            System.out.println("Token successfully saved to Firestore.");
        } catch (InterruptedException | ExecutionException e) {
            Thread.currentThread().interrupt(); // Khôi phục trạng thái bị ngắt
            throw new RuntimeException("Failed to save token to Firestore: " + e.getMessage(), e);
        }
    }



    @Override
    public boolean checkTokenExist(String token) {
        return false;
    }
}
