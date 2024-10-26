package com.best.springbest.controller;

import com.best.springbest.model.Brand;
import com.best.springbest.service.BrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@CrossOrigin(origins = "*")
@RestController
public class BrandController {
    @Autowired
    BrandService brandService;
    @RequestMapping(value = "api/best_app/brand/all", method = RequestMethod.GET)
    public List<Brand> getAllBrands(){
        return brandService.getAllBrand();
    }
    @RequestMapping(value = "api/best_app/brand/detail", method = RequestMethod.GET)
    public Object getBrandByID(@RequestParam int id){
        return brandService.getBrandByID(id);
    }
    @RequestMapping(value = "api/best_app/brand/create", method = RequestMethod.POST)
    public boolean addBrand(@RequestBody Brand brand) {
        return brandService.addBrand(brand);
    }
    @RequestMapping(value = "api/best_app/brand/update", method = RequestMethod.PUT)
    public boolean updateBrand(@RequestBody Brand brand) {
        return brandService.updateBrand(brand);
    }
    @RequestMapping(value = "api/best_app/brand/delete", method = RequestMethod.DELETE)
    public boolean removeBrand(@RequestParam int id){
        return brandService.removeBrand(id);
    }
}
