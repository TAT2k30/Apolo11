package com.project.apolo11.features.tours.service;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import com.project.apolo11.features.account.domains.entities.Account;
import com.project.apolo11.features.tours.domains.TourRequest;
import com.project.apolo11.features.tours.domains.Tours;
import com.project.apolo11.features.trip.domains.entities.Trip;
import com.project.apolo11.utils.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

@Service
public class ToursService {
    @Autowired
    private FileService fileService;


    public Tours saveTour(TourRequest tourRequest, String token) {
        Firestore dbFireStore = FirestoreClient.getFirestore();
        try{
            DocumentReference accountDocRef = dbFireStore.collection("accessToken").document(token);
            ApiFuture<DocumentSnapshot> future = accountDocRef.get();
            DocumentSnapshot checkToken = future.get();

            if(checkToken.exists()){
                 Tours savedTour = new Tours();
                String thumbnail = null;
                if (tourRequest.getImage() != null && !tourRequest.getImage().isEmpty()) {
                    thumbnail = fileService.upload("tour/",tourRequest.getImage());
                }
                String id = tourRequest.getId();
                if(id != null){
                    savedTour.setId(id);
                }else{
                    savedTour.setId(UUID.randomUUID().toString());
                }
                savedTour.setName(tourRequest.getName());
                savedTour.setDeparture(tourRequest.getDeparture());
                savedTour.setDestination(tourRequest.getDestination());
                savedTour.setImageUrl(thumbnail);
                savedTour.setDescription(tourRequest.getDescription());
                savedTour.setCreatedAt(Instant.now());
                dbFireStore.collection("tour").document(savedTour.getId()).set(savedTour);
                return savedTour;
            }else{
                throw new RuntimeException("Token is invalid");
            }
        }catch(InterruptedException | ExecutionException e){
            Thread.currentThread().interrupt();
            throw new RuntimeException("Failed to retrieve account: " + e.getMessage(), e);
        }
    }
    public Tours getTourById(String id) {
        Firestore dbFireStore = FirestoreClient.getFirestore();
        DocumentReference docRef = dbFireStore.collection("tour").document(id);
        try {
            DocumentSnapshot document = docRef.get().get();
            if (document.exists()) {
                Tours tour = document.toObject(Tours.class);
                return tour;
            } else {
               return null;
            }
        } catch (InterruptedException | ExecutionException e) {
            throw new RuntimeException("Failed to retrieve tour: " + e.getMessage(), e);
        }
    }

    public List<Tours> findAllTour() {
        Firestore dbFireStore = FirestoreClient.getFirestore();
        try {
            // Lấy tất cả các tài liệu trong bộ sưu tập "tour"
            QuerySnapshot querySnapshot = dbFireStore.collection("tour").get().get();

            List<Tours> toursList = new ArrayList<>();
            if (querySnapshot != null) {
                for (QueryDocumentSnapshot document : querySnapshot) {
                    Tours tour = document.toObject(Tours.class);
                    tour.setId(document.getId()); // Gán ID tài liệu vào đối tượng Tours
                    toursList.add(tour);
                }
            }
            return toursList;
        } catch (InterruptedException | ExecutionException e) {
            throw new RuntimeException("Failed to retrieve tours: " + e.getMessage(), e);
        }
    }
    public void deleteTourById(String id) {
        Firestore dbFireStore = FirestoreClient.getFirestore();
        try {
            dbFireStore.collection("tour").document(id).delete().get();  // Thực hiện xóa tài liệu
        } catch (InterruptedException | ExecutionException e) {
            throw new RuntimeException("Failed to delete tour: " + e.getMessage(), e);
        }
    }
}
