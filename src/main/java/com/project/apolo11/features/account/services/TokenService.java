package com.project.apolo11.features.account.services;

import com.project.apolo11.features.account.domains.entities.Token;

public interface TokenService {
    String checkTokenRole(Token token, String rawPassword);
    void saveTokenToFireStore(String token);
    boolean checkTokenExist(String token);
}
