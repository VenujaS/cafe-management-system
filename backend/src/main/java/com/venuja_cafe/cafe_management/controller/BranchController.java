package com.venuja_cafe.cafe_management.controller;

import com.venuja_cafe.cafe_management.model.Branch;
import com.venuja_cafe.cafe_management.service.BranchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/branches")
@CrossOrigin
public class BranchController {

    @Autowired
    private BranchService branchService;

    @GetMapping
    public List<Branch> getAllBranches() {
        return branchService.getAllBranches();
    }

    @GetMapping("/{id}")
    public Optional<Branch> getBranchById(@PathVariable String id) {
        return branchService.getBranchById(id);
    }

    @PostMapping
    public Branch addBranch(@RequestBody Branch branch) {
        return branchService.addBranch(branch);
    }

    @PutMapping("/{id}")
    public Branch updateBranch(@PathVariable String id, @RequestBody Branch branch) {
        return branchService.updateBranch(id, branch);
    }

    @DeleteMapping("/{id}")
    public void deleteBranch(@PathVariable String id) {
        branchService.deleteBranch(id);
    }
}
