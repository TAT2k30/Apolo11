package com.project.apolo11.features.account.services;

import com.project.apolo11.features.account.domains.dtos.request.LoginRequest;
import com.project.apolo11.features.account.domains.dtos.request.RegisterRequest;
import com.project.apolo11.features.account.domains.dtos.request.UpdateAccountRequest;
import com.project.apolo11.features.account.domains.entities.Account;

import java.util.concurrent.ExecutionException;

public interface AccountService {
    Account login(LoginRequest loginRequest);
    Account register(RegisterRequest registerRequest);
    void logout(String privateAccountToken);
    void changePassword();
    void forgotPassword();
    void resetPassword();
    void verifyEmail();
    Account getAccountById(String id);
    Account updateAccount(UpdateAccountRequest updateAccountRequest, String avatarUrl, String email) throws ExecutionException, InterruptedException;
}
