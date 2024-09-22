package com.project.apolo11.handler;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(ConflictException.class)
    public ResponseEntity<ExceptionResponse> handleConflictException(ConflictException ext) {
        return ResponseEntity
                .status(HttpStatus.CONFLICT)
                .body(
                        ExceptionResponse.builder()
                                .message("Resources are duplicated")
                                .error(ext.getMessage())
                                .statusCode(HttpStatus.CONFLICT.value())
                                .build()
                );
    }

    @ExceptionHandler(NotFoundException.class)
    public ResponseEntity<ExceptionResponse> handleNotFoundException(NotFoundException ext) {
        return ResponseEntity
                .status(HttpStatus.NOT_FOUND)
                .body(
                        ExceptionResponse.builder()
                                .message("Resource not found")
                                .error(ext.getMessage())
                                .statusCode(HttpStatus.NOT_FOUND.value())
                                .build()
                );
    }

    @ExceptionHandler(ForBiddenException.class)
    public ResponseEntity<ExceptionResponse> handleForbiddenException(ForBiddenException ext) {
        return ResponseEntity
                .status(HttpStatus.FORBIDDEN)
                .body(
                        ExceptionResponse.builder()
                                .message("Access denied")
                                .error(ext.getMessage())
                                .statusCode(HttpStatus.FORBIDDEN.value())
                                .build()
                );
    }

    @ExceptionHandler(UnprocessableException.class)
    public ResponseEntity<ExceptionResponse> handleUnprocessableException(UnprocessableException ext) {
        return ResponseEntity
                .status(HttpStatus.UNPROCESSABLE_ENTITY)
                .body(
                        ExceptionResponse.builder()
                                .message("Invalid format")
                                .error(ext.getMessage())
                                .statusCode(HttpStatus.UNPROCESSABLE_ENTITY.value())
                                .build()
                );
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ExceptionResponse> handleMethodArgumentNotValidException(MethodArgumentNotValidException exp) {
        Map<String, String> errors = new HashMap<>();

        exp.getBindingResult().getAllErrors().forEach(error -> {
            String fieldName;
            String errorMessage = error.getDefaultMessage();
            if (error instanceof FieldError) {
                FieldError fieldError = (FieldError) error;
                fieldName = fieldError.getField();
            } else {
                fieldName = error.getObjectName();
            }
            errors.put(fieldName, errorMessage);
        });

        return ResponseEntity
                .status(HttpStatus.UNPROCESSABLE_ENTITY)
                .body(
                        ExceptionResponse.builder()
                                .message("Invalid format")
                                .validationErrors(errors)
                                .statusCode(HttpStatus.UNPROCESSABLE_ENTITY.value())
                                .build()
                );
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ExceptionResponse> handleException(Exception exp) {
        exp.printStackTrace();
        return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(
                        ExceptionResponse.builder()
                                .message("Internal server error")
                                .error(exp.getMessage())
                                .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
                                .build()
                );
    }

}
