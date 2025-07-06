package com.venuja_cafe.cafe_management;

import com.venuja_cafe.cafe_management.model.Staff;
import com.venuja_cafe.cafe_management.service.StaffService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/staff")
@CrossOrigin(origins = "*") // to allow frontend access during development
public class StaffController {

    private final StaffService staffService;

    public StaffController(StaffService staffService) {
        this.staffService = staffService;
    }

    @PostMapping("/add")
    public ResponseEntity<Staff> addStaff(@RequestBody Staff staff) {
        return ResponseEntity.ok(staffService.addStaff(staff));
    }

    @GetMapping("/list")
    public ResponseEntity<List<Staff>> listStaff() {
        return ResponseEntity.ok(staffService.getAllStaff());
    }
}
