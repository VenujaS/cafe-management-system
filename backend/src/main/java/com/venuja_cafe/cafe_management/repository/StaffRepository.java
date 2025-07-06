package com.venuja_cafe.cafe_management.repository;

import com.venuja_cafe.cafe_management.model.Staff;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StaffRepository extends JpaRepository<Staff, String> {
}
