package com.project.apolo11.features.file.controllers;


import com.project.apolo11.common.ResultResponse;
import com.project.apolo11.features.account.domains.entities.Account;
import com.project.apolo11.utils.FileService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/api/v1/file")
public class FileController {

    private final FileService fileService;
    public FileController(FileService fileService) {
        this.fileService = fileService;
    }

    @PostMapping("/upload")
    public ResponseEntity<ResultResponse<?>> uploadFile(
            @RequestParam("file") MultipartFile multipartFile
    ){
       try{
           return ResponseEntity.ok(
                   ResultResponse.<String>builder()
                           .timeStamp(LocalDateTime.now().toString())
                           .body(fileService.upload(multipartFile))
                           .message("Create image successFully")
                           .status(HttpStatus.OK)
                           .statusCode(HttpStatus.OK.value())
                           .build()
           );
       }catch(Exception e){
           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                   .body(ResultResponse.<Boolean>builder()
                           .timeStamp(LocalDateTime.now().toString())
                           .body(false)
                           .message("Logout failed, please try again later")
                           .status(HttpStatus.INTERNAL_SERVER_ERROR)
                           .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
                           .build());
       }
    }
}
