package com.project.apolo11.features.account.utils;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum Role {
    ADMIN_ID("ZCDo3qliyQts8eEm0clC"),
    USER_ID("Anr4a1za3OCf173H0hdc");

    private final String value;

    public String value() {return this.value;}
}
