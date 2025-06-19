package com.example.mid_assignment.model;

import lombok.*;

import java.sql.Timestamp;


    @AllArgsConstructor
    @NoArgsConstructor
    @Getter
    @Setter
    @ToString
    public class Complain{
        private int id;
        private String title;
        private String description;
        private String category;
        private String status;
        private String priority;
        private String submittedBy;
        private Integer assignedTo;
        private String adminRemarks;
        private Timestamp createdAt;
        private Timestamp updatedAt;

        // Additional fields for display
        private String submitterName;
        private String assigneeName;

        public Complain(String title, String description, String category, String submittedBy) {
            this.title = title;
            this.description = description;
            this.category = category;
            this.submittedBy = submittedBy;
            this.status = "PENDING";
            this.priority = "MEDIUM";
        }

        public Complain(int id, String title, String description, String category, String priority) {

        }
    }



