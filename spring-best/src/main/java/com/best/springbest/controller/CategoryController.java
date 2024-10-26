package com.best.springbest.controller;

import com.best.springbest.model.Category;
import com.best.springbest.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@CrossOrigin(origins = "*")
@RestController
public class CategoryController {
    @Autowired
    CategoryService categoryService;
    @RequestMapping(value = "api/best_app/category/all", method = RequestMethod.GET)
    public List<Category> getAllCategory(){
        return categoryService.getAllCategory();
    }
    @RequestMapping(value = "api/best_app/category/detail", method = RequestMethod.GET)
    public Category getCategoryByID(@RequestParam int id){
        return categoryService.getCategoryByID(id);
    }
    @RequestMapping(value = "api/best_app/category/create", method = RequestMethod.POST)
    public boolean addCategory(@RequestBody Category ob) {
        return categoryService.addCategory(ob);
    }
    @RequestMapping(value = "api/best_app/category/update", method = RequestMethod.PUT)
    public boolean updateCategory(@RequestBody Category ob){
        return categoryService.updateCategory(ob);
    }
    @RequestMapping(value = "api/best_app/category/delete", method = RequestMethod.DELETE)
    public boolean removeCategory(@RequestParam int id){
        return categoryService.removeCategory(id);
    }
}
