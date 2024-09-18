package com.project.apolo11;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;

import java.io.IOException;
import java.io.InputStream;
import java.util.Objects;

@SpringBootApplication
@EnableAsync
@EnableScheduling
public class Apolo11Application {

	public static void main(String[] args) throws IOException {
		// Kiểm tra xem FirebaseApp đã được khởi tạo chưa
		if (FirebaseApp.getApps().isEmpty()) {
			// Lấy file serviceAccountKey.json từ classpath (resources folder)
			try (InputStream serviceAccount = Apolo11Application.class.getClassLoader()
					.getResourceAsStream("serviceAccountKey.json")) {

				if (serviceAccount == null) {
					throw new IllegalStateException("File serviceAccountKey.json không tồn tại trong classpath.");
				}

				FirebaseOptions options = new FirebaseOptions.Builder()
						.setCredentials(GoogleCredentials.fromStream(serviceAccount))
						.setDatabaseUrl("https://apolo11-27419-default-rtdb.firebaseio.com")
						.build();

				FirebaseApp.initializeApp(options);
			}
		}

		SpringApplication.run(Apolo11Application.class, args);
	}
}
