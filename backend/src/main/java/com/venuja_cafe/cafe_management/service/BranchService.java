package com.venuja_cafe.cafe_management.service;

import com.venuja_cafe.cafe_management.model.Branch;
import com.venuja_cafe.cafe_management.repository.BranchRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BranchService {

    @Autowired
    private BranchRepository branchRepository;

    public List<Branch> getAllBranches() {
        return branchRepository.findAll();
    }

    public Optional<Branch> getBranchById(String id) {
        return branchRepository.findById(id);
    }

    public Branch addBranch(Branch branch) {
        return branchRepository.save(branch);
    }

    public void deleteBranch(String id) {
        branchRepository.deleteById(id);
    }

    public Branch updateBranch(String id, Branch updatedBranch) {
        updatedBranch.setBranchId(id);
        return branchRepository.save(updatedBranch);
    }
}
