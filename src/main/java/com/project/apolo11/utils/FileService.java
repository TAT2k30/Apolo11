package com.project.apolo11.utils;

import com.google.auth.Credentials;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.*;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.project.apolo11.Apolo11Application;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.UUID;
@Service
public class FileService {

    private static final String BUCKET_NAME = "techwizt5.appspot.com";
    private static final String DOWNLOAD_URL = "https://firebasestorage.googleapis.com/v0/b/" + BUCKET_NAME + "/o/%s?alt=media";
    private Storage storage = null;

    private Storage getStorage() {
        return StorageOptions.getDefaultInstance().getService();
    }

    private String uploadFile(String folder,File file, String fileName, String contentType) throws IOException {
        String folderName = folder;
        BlobId blobId = BlobId.of(BUCKET_NAME, folderName + fileName);
        BlobInfo blobInfo = BlobInfo.newBuilder(blobId).setContentType(contentType).build();

        this.storage.create(blobInfo, Files.readAllBytes(file.toPath()));

        return String.format(DOWNLOAD_URL, URLEncoder.encode(folderName + fileName, StandardCharsets.UTF_8));
    }

    private File convertToFile(MultipartFile multipartFile, String fileName) throws IOException {
        File tempFile = new File(fileName);
        try (FileOutputStream fos = new FileOutputStream(tempFile)) {
            fos.write(multipartFile.getBytes());
        }
        return tempFile;
    }

    private String getExtension(String fileName) {
        return fileName.substring(fileName.lastIndexOf("."));
    }

    public String upload(String folder,MultipartFile multipartFile) {
        try {
            try (InputStream serviceAccount = Apolo11Application.class.getClassLoader()
                    .getResourceAsStream("serviceAccountKey.json")) {

                if (serviceAccount == null) {
                    throw new IllegalStateException("File serviceAccountKey.json không tồn tại trong classpath.");
                }

                this.storage = StorageOptions.newBuilder()
                        .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                        .setProjectId("techwizt5")
                        .build().getService();
            }

            String fileName = multipartFile.getOriginalFilename();
            fileName = UUID.randomUUID().toString().concat(this.getExtension(fileName));

            File file = this.convertToFile(multipartFile, fileName);
            String URL = this.uploadFile(folder,file, fileName, multipartFile.getContentType());
            file.delete();
            return URL;
        } catch (Exception e) {
            e.printStackTrace();
            return "Image couldn't upload, Something went wrong";
        }
    }
}

