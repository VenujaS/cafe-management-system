package com.venuja_cafe.cafe_management.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "Branches")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Branch {

    @Id
    @Column(name = "Branch_id", nullable = false, length = 10)
    private String branchId;

    @Column(name = "Location")
    private String location;

    @Column(name = "Email")
    private String email;

    @Column(name = "Phone_number")
    private String phoneNumber;

    @Column(name = "Manager_id", length = 30)
    private String managerId;
}
