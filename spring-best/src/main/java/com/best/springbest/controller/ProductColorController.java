package com.best.springbest.controller;

import com.best.springbest.dto.ProductColorDto;
import com.best.springbest.model.ProductColor;
import com.best.springbest.service.ProductColorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@CrossOrigin(origins = "*")
@RestController
public class ProductColorController {
    @Autowired
    ProductColorService productColorService;
    @RequestMapping(value = "api/best_app/product_color/all", method = RequestMethod.GET)
    public List<ProductColor> getAllProductColor(){
        return productColorService.getAllProductColor();
    }
    @RequestMapping(value = "api/best_app/product_color/detail", method = RequestMethod.GET)
    public ProductColor getProductColorByID(@RequestParam int id){
        return productColorService.getProductColorByID(id);}
    @RequestMapping(value = "api/best_app/product_color/byProductID", method = RequestMethod.GET)
    public List<ProductColor> getProductColorByProductID(@RequestParam int id){
        return productColorService.getListImageByProductID(id);}
    @RequestMapping(value = "api/best_app/product_color/byProductIdAndColorID", method = RequestMethod.GET)
    public List<ProductColor> getProductColorByProductIdAndColorID(@RequestParam int productID, @RequestParam int colorID){
        return productColorService.getProductColorByProductIdAndColorID(productID, colorID);}
    @RequestMapping(value = "api/best_app/product_color/create", method = RequestMethod.POST)
    public boolean addProductColor(@RequestBody ProductColorDto ob) {
        return productColorService.addProductColor(ob);}
    @RequestMapping(value = "api/best_app/product_color/update", method = RequestMethod.PUT)
    public boolean updateProductColor(@RequestBody ProductColorDto ob){
        return productColorService.updateProductColor(ob);}
    @RequestMapping(value = "api/best_app/product_color/delete", method = RequestMethod.DELETE)
    public boolean removeProductColor(@RequestParam int id){
        return productColorService.removeProductColor(id);
    }
}
