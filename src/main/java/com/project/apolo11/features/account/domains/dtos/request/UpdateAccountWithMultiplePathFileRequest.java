package com.project.apolo11.features.account.domains.dtos.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import org.springframework.web.multipart.MultipartFile;
@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class UpdateAccountWithMultiplePathFileRequest {
    private String userName;
    private String gender;
    private MultipartFile file;
}
