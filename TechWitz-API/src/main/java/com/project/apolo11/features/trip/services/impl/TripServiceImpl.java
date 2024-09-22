package com.project.apolo11.features.trip.services.impl;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.cloud.FirestoreClient;
import com.project.apolo11.features.account.domains.entities.Account;
import com.project.apolo11.features.account.utils.AccountUtils;
import com.project.apolo11.features.account.utils.Role;
import com.project.apolo11.features.trip.domains.dtos.request.CreateTripRequest;
import com.project.apolo11.features.trip.domains.entities.Trip;
import com.project.apolo11.features.trip.services.TripService;
import com.project.apolo11.features.trip.utils.Status;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;
import java.util.concurrent.ExecutionException;

@Service
public class TripServiceImpl implements TripService {
    private final AccountUtils accountUtils;

    public TripServiceImpl(AccountUtils accountUtils) {
        this.accountUtils = accountUtils;
    }

    @Override
    public Trip createTrip(CreateTripRequest trip, String token) {
        Firestore dbFireStore = FirestoreClient.getFirestore();
        try {
            // Lấy document từ collection "accessToken" dựa trên token
            DocumentReference accountDocRef = dbFireStore.collection("accessToken").document(token);
            ApiFuture<DocumentSnapshot> future = accountDocRef.get();
            DocumentSnapshot checkToken = future.get();

            if (checkToken.exists()) {
                // Chuyển đổi dữ liệu từ Firestore sang đối tượng Account
                Account accountFromFireStore = checkToken.toObject(Account.class);

                // Tạo đối tượng Trip mới và set các thuộc tính từ CreateTripRequest
                Trip savedTrip = new Trip();
                savedTrip.setId(UUID.randomUUID().toString());
                savedTrip.setName(trip.getName());  // Lấy tên từ CreateTripRequest
                savedTrip.setStartDate(trip.getStartDate());  // Start date và end date phải khớp kiểu dữ liệu
                savedTrip.setEndDate(trip.getEndDate());
                savedTrip.setStatus(Status.ACTIVE);
                savedTrip.setCreatedAt(Instant.now());
                savedTrip.setUpdatedAt(Instant.now());
                savedTrip.setTotalBudget(trip.getTotalBudget());  // Budget lấy từ CreateTripRequest
                savedTrip.setDescription(trip.getDescription());  // Mô tả chuyến đi
                savedTrip.setExpenses(trip.getExpenses());  // Set danh sách các chi phí từ Flutter

                // Danh sách tài khoản tham gia vào trip
                List<String> accounts = new ArrayList<>();
                accounts.add(accountFromFireStore.getId());
                savedTrip.setAccounts(accounts);
                savedTrip.setCreatedBy(accountFromFireStore.getId());

                // Lưu đối tượng Trip vào Firestore
                dbFireStore.collection("trips").document(savedTrip.getId()).set(savedTrip);

                return savedTrip;
            } else {
                throw new RuntimeException("Token is invalid");
            }
        } catch (InterruptedException | ExecutionException e) {
            Thread.currentThread().interrupt();
            throw new RuntimeException("Failed to retrieve account: " + e.getMessage(), e);
        }
    }


    @Override
    public void deleteTrip() {

    }

    @Override
    public Trip updateTrip() {
        return null;
    }

    @Override
    public Trip getTrip() {
        return null;
    }

    @Override
    public List<Trip> getAllTrips(String token) {
        if(!Objects.equals(accountUtils.getRoleByToken(token), "USER") || !Objects.equals(accountUtils.getRoleByToken(token), "ADMIN")){
            throw new RuntimeException("Invalid Role");
        }

        Firestore dbFireStore = FirestoreClient.getFirestore();
        String email = accountUtils.getEmailByToken(token);

        try{
            DocumentReference accountDocRef = dbFireStore.collection("accessToken").document(token);
            ApiFuture<DocumentSnapshot> future = accountDocRef.get();
            DocumentSnapshot checkToken = future.get();

            if(checkToken != null){
                return null;
            }else{
                throw new RuntimeException("Token is invalid");
            }
        }catch(Exception e) {
            throw new RuntimeException("Failed to retrieve trips: " + e.getMessage(), e);
        }
    }
}
