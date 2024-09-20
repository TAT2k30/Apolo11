package com.project.apolo11.features.account.utils;

import com.project.apolo11.features.account.domains.entities.Account;
import org.springframework.stereotype.Component;

@Component
public class AccountUtils {
    private String FEMALE_DEFAULT_URL_AVATAR = "http://localhost:8080/api/v1/avatar/static/defaultAvatar/femaleAvatar/female.png";
    private String MALE_DEFAULT_URL_AVATAR = "http://localhost:8080/api/v1/avatar/static/defaultAvatar/maleAvatar/male.png";

    public String getFemaleAvatar(){
        return FEMALE_DEFAULT_URL_AVATAR;
    }

    public String getMaleAvatar(){
        return MALE_DEFAULT_URL_AVATAR;
    }

    public String generateAccountPrivateToken (Account account) {
        return account.getEmail() + "-" + account.getRole();
    }
}
