package com.best.springbest.controller;

import com.best.springbest.dto.ProductSizeDto;
import com.best.springbest.model.ProductSize;
import com.best.springbest.service.ProductSizeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@CrossOrigin(origins = "*")
@RestController
public class ProductSizeController {
    @Autowired
    ProductSizeService productSizeService;
    @RequestMapping(value = "api/best_app/product_size/all", method = RequestMethod.GET)
    public List<ProductSize> getAllProductSizes(){
        return productSizeService.getAllProductSize();
    }
    @RequestMapping(value = "api/best_app/product_size/detail", method = RequestMethod.GET)
    public Object getProductSizeByID(@RequestParam int id){
        return productSizeService.getProductSizeByID(id);
    }
    @RequestMapping(value = "api/best_app/product_size/byProduct", method = RequestMethod.GET)
    public List<ProductSize> getProductSizeByProductID(@RequestParam int productID){
        return productSizeService.getProductSizeByProductID(productID);}

    @RequestMapping(value = "api/best_app/product_size/byProductID_SizeID", method = RequestMethod.GET)
    public List<ProductSize> getProductSizeByProductIdAndSizeID(@RequestParam int productID, @RequestParam int sizeID){
        return productSizeService.getProductSizeByProductIdAndSizeID(productID, sizeID);}
    @RequestMapping(value = "api/best_app/product_size/create", method = RequestMethod.POST)
    public boolean addProductSize(@RequestBody ProductSizeDto productSizeDto) {
        return productSizeService.addProductSize(productSizeDto);}
    @RequestMapping(value = "api/best_app/product_size/update", method = RequestMethod.PUT)
    public boolean updateProductSize(@RequestBody ProductSizeDto productSizeDto) {
        return productSizeService.updateProductSize(productSizeDto);}
    @RequestMapping(value = "api/best_app/product_size/delete", method = RequestMethod.DELETE)
    public boolean removeProductSize(@RequestParam int id){
        return productSizeService.removeProductSize(id);
    }
}
