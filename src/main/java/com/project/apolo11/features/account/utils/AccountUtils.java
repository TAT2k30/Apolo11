package com.project.apolo11.features.account.utils;

import com.project.apolo11.features.account.domains.entities.Account;
import org.springframework.stereotype.Component;

@Component
public class AccountUtils {
    private String FEMALE_DEFAULT_URL_AVATAR = "https://firebasestorage.googleapis.com/v0/b/techwizt5.appspot.com/o/account%2Ffemale.png?alt=media&token=98326b4a-67eb-4bb2-8f5e-30fd64fc6b3d";
    private String MALE_DEFAULT_URL_AVATAR = "https://firebasestorage.googleapis.com/v0/b/techwizt5.appspot.com/o/account%2Fmale.png?alt=media&token=5d14ec5f-4908-4818-9bda-89f2a446ed61";

    public String getFemaleAvatar(){
        return FEMALE_DEFAULT_URL_AVATAR;
    }

    public String getMaleAvatar(){
        return MALE_DEFAULT_URL_AVATAR;
    }

    public String generateAccountPrivateToken (Account account) {
        return account.getEmail() + "-" + account.getRole();
    }

    public String getRoleByToken(String token){
        String[] tokenParts = token.split("-");
        return tokenParts[tokenParts.length - 1];
    }

    public String getEmailByToken(String token){
        String[] tokenParts = token.split("-");
        return tokenParts[0];
    }
}
