package com.venuja_cafe.cafe_management.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "Staff")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Staff {

    @Id
    @Column(name = "Staff_id", nullable = false, length = 30)
    private String staffId;

    @Column(name = "Name")
    private String name;

    @Column(name = "National_ID_no", nullable = false, unique = true)
    private String nationalIdNo;

    @Column(name = "Position")
    private String position;

    @Column(name = "Email")
    private String email;

    @Column(name = "Phone_number")
    private String phoneNumber;

    @Column(name = "Address", columnDefinition = "TEXT")
    private String address;

    @ManyToOne
    @JoinColumn(name = "Branch_id", referencedColumnName = "Branch_id")
    private Branch branch;
}

