package com.project.apolo11.features.trip.utils;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum Status {
    CANCELED("Canceled"),
    ACTIVE("Active"),
    FINISHED("Finished");;

    private final String status;

    public static Status fromString(String status) {
        for (Status b : Status.values()) {
            if (b.status.equalsIgnoreCase(status)) {
                return b;
            }
        }
        return null;
    }

    public static String getStatus(Status status) {
        return status.getStatus();
    }

}
