package com.best.springbest.controller;

import com.best.springbest.dto.ProductDto;
import com.best.springbest.model.Product;
import com.best.springbest.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@CrossOrigin(origins = "*")
@RestController
public class ProductController {
    @Autowired
    ProductService productService;
    @RequestMapping(value = "api/best_app/product/all", method = RequestMethod.GET)
    public List<Product> getAllProducts(){
        return productService.getAllProduct();
    }
    @RequestMapping(value = "api/best_app/product/action", method = RequestMethod.GET)
    public List<Product> getAllProductAction(){
        return productService.getAllProductAction();
    }
    @RequestMapping(value = "api/best_app/product/detail", method = RequestMethod.GET)
    public Product getProductByID(@RequestParam int id){
        return productService.getProductByID(id);
    }
    @RequestMapping(value = "api/best_app/product/search", method = RequestMethod.GET)
    public List<Product> searchProductByName(@RequestParam String text){
        return productService.searchProductByName(text);}
    @RequestMapping(value = "api/best_app/product/byCategory", method = RequestMethod.GET)
    public List<Product> findProductByCategoryID(@RequestParam int categoryID){
        return productService.findProductByCategoryID(categoryID);}
    @RequestMapping(value = "api/best_app/product/byBrand", method = RequestMethod.GET)
    public List<Product> findProductByBrandID(@RequestParam int brandID){
        return productService.findProductByBrandID(brandID);}
    @RequestMapping(value = "api/best_app/product/remain", method = RequestMethod.GET)
    public List<Product> findProductRemain(@RequestParam int shopID, @RequestParam int productID){
        return productService.findProductRemain(shopID, productID);}
    @RequestMapping(value = "api/best_app/product/byShop", method = RequestMethod.GET)
    public List<Product> findProductByShopID(@RequestParam int shopID){
        return productService.findProductByShopID(shopID);}
    @RequestMapping(value = "api/best_app/product/create", method = RequestMethod.POST)
    public boolean addProduct(@RequestBody ProductDto product){
        return productService.addProduct(product);
    }
    @RequestMapping(value = "api/best_app/product/update", method = RequestMethod.PUT)
    public boolean updateProduct(@RequestBody ProductDto product){
        return productService.updateProduct(product);
    }
    @RequestMapping(value = "api/best_app/product/delete", method = RequestMethod.DELETE)
    public boolean removeProduct(@RequestParam int id){
        return productService.removeProduct(id);
    }

    //Sort
    @RequestMapping(value = "api/best_app/product/name", method = RequestMethod.GET)
    public List<Product> getProductName(){
        return productService.getProductName();
    }
    @RequestMapping(value = "api/best_app/product/height_price", method = RequestMethod.GET)
    public List<Product> getProductHeightPrice(){
        return productService.getProductHeightPrice();
    }
    @RequestMapping(value = "api/best_app/product/low_price", method = RequestMethod.GET)
    public List<Product> getProductLowPrice(){
        return productService.getProductLowPrice();
    }
    @RequestMapping(value = "api/best_app/product/sale", method = RequestMethod.GET)
    public List<Product> getProductSale(){
        return productService.getProductSale();
    }
    @RequestMapping(value = "api/best_app/product/new", method = RequestMethod.GET)
    public List<Product> getProductNew(){
        return productService.getProductNew();
    }
    @RequestMapping(value = "api/best_app/product/popular", method = RequestMethod.GET)
    public List<Product> getProductPopular(){
        return productService.getProductPopular();
    }

}
