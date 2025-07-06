package com.venuja_cafe.cafe_management.repository;

import com.venuja_cafe.cafe_management.model.Branch;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BranchRepository extends JpaRepository<Branch, String> {
    // Add custom queries here if needed
}
