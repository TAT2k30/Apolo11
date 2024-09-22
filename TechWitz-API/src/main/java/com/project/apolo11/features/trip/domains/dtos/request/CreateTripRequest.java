package com.project.apolo11.features.trip.domains.dtos.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.time.Instant;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class CreateTripRequest {

    @NotBlank(message = "Trip name is required")
    private String name;  // Thay đổi từ tripName thành name để khớp với dữ liệu Flutter gửi

    @NotNull(message = "Total budget is required")
    private int totalBudget;

    @NotNull(message = "Start date is required")
    private Instant startDate;

    @NotNull(message = "End date is required")
    private Instant endDate;

    @NotBlank(message = "Description is required")
    private String description;

    @NotBlank(message = "Destination name is required")
    private String destinationName;

    /**
     * Kiểm tra xem endDate có sau startDate hay không.
     *
     * @return true nếu endDate hợp lệ, ngược lại false.
     */
    public boolean isEndDateValid() {
        if (startDate != null && endDate != null) {
            return endDate.isAfter(startDate);
        }
        return false;
    }
}
