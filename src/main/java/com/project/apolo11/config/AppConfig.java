package com.project.apolo11.config;


import com.project.apolo11.features.account.services.TokenService;
import com.project.apolo11.features.account.services.impl.AccountServiceImpl;
import com.project.apolo11.features.account.utils.AccountUtils;
import com.project.apolo11.features.account.utils.PasswordUtils;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {
    @Bean
    public AccountUtils accountUtils(){
        return new AccountUtils();
    }

    @Bean
    public PasswordUtils passwordUtils(){
        return new PasswordUtils();
    }

}
