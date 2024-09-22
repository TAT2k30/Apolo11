package com.project.apolo11.features.email.services.impl;

import com.project.apolo11.features.email.services.EmailService;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.thymeleaf.context.Context;
import org.thymeleaf.spring6.SpringTemplateEngine;

import java.nio.charset.StandardCharsets;
import java.util.Map;

@Service
public class EmailServiceImpl implements EmailService {
    public static final String NEW_USER_ACCOUNT_VERIFICATION = "New User Account Verification";
    public static final String UTF_8_ENCODING = StandardCharsets.UTF_8.name();
    public static final String EMAIL_TEMPLATE = "emailTemplate";
//    @Value("${spring.pulsar.client.service-url}")
//    private String serverUrl;
//
//    @Value("${spring.mail.verify}")
//    private String verifyUrl;
//
//    @Value("${spring.mail.username}")
//    private String fromEmail;

    private final JavaMailSender javaMailSender;
    private final SpringTemplateEngine templateEngine;

    public EmailServiceImpl(JavaMailSender javaMailSender, SpringTemplateEngine templateEngine) {
        this.javaMailSender = javaMailSender;
        this.templateEngine = templateEngine;
    }

    @Override
    @Async
    public void sendHtmlEmail(String name, String to, String digitCode) {
        try {
            Context context = new Context();

            context.setVariables(Map.of("name", name, "url", digitCode));

            String text = templateEngine.process(EMAIL_TEMPLATE, context);

            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, UTF_8_ENCODING);

            helper.setPriority(1);
            helper.setSubject(NEW_USER_ACCOUNT_VERIFICATION);
//            helper.setFrom(fromEmail);
            helper.setTo(to);
            helper.setText(text, true);

            javaMailSender.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException("Error sending HTML email: " + e.getMessage(), e);
        } catch (Exception e) {
            throw new RuntimeException("Unexpected error sending HTML email", e);
        }
    }

}
