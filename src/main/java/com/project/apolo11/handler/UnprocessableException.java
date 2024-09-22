package com.project.apolo11.handler;

public class UnprocessableException extends RuntimeException{
    public UnprocessableException(String message) {
        super(message);
    }

    public UnprocessableException(String message, Throwable cause) {
        super(message, cause);
    }

    public UnprocessableException(Throwable cause) {
        super(cause);
    }
}
