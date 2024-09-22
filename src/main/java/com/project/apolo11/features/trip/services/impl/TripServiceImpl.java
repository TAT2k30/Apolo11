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
       try{
           DocumentReference accountDocRef = dbFireStore.collection("accessToken").document(token);
           ApiFuture<DocumentSnapshot> future = accountDocRef.get();
           DocumentSnapshot checkToken = future.get();

           if(checkToken.exists()){
               Account accountFromFireStore = checkToken.toObject(Account.class);

               Trip savedTrip = new Trip();
               savedTrip.setId(UUID.randomUUID().toString());
               savedTrip.setDestinationId(trip.getDestinationId());
               savedTrip.setStartDate(trip.getStartDate());
               savedTrip.setEndDate(trip.getEndDate());
               savedTrip.setStatus(Status.ACTIVE);
               savedTrip.setCreatedAt(Instant.now());
               savedTrip.setUpdatedAt(Instant.now());
               savedTrip.setTotalBudget(trip.getTotalBudget());
               savedTrip.setDestinationId(trip.getDestinationId());
               savedTrip.setDescription(trip.getDescription());

               List<String> accounts = new ArrayList<>();
               accounts.add(accountFromFireStore.getId());
               savedTrip.setAccounts(accounts);
               savedTrip.setCreatedBy(accountFromFireStore.getId());

               //Lưu vào FireStore
               dbFireStore.collection("trips").document(savedTrip.getId()).set(savedTrip);
               return savedTrip;
           }else{
               throw new RuntimeException("Token is invalid");
           }
       }catch(InterruptedException | ExecutionException e){
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
