package com.best.springbest.controller;

import com.best.springbest.dto.ProductDetailDto;
import com.best.springbest.model.ProductDetail;
import com.best.springbest.service.ProductDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@CrossOrigin(origins = "*")
@RestController
public class ProductDetailController {
    @Autowired
    ProductDetailService productDetailService;
    @RequestMapping(value = "api/best_app/product_detail/all", method = RequestMethod.GET)
    public List<ProductDetail> getAllProductDetails(){
        return productDetailService.getAllProductDetail();
    }
    @RequestMapping(value = "api/best_app/product_detail/detail", method = RequestMethod.GET)
    public Object getProductDetailByID(@RequestParam int id){
        return productDetailService.getProductDetailByID(id);
    }
    @RequestMapping(value = "api/best_app/product_detail/byShopID", method = RequestMethod.GET)
    public List<ProductDetail> getProductDetailByShopID(@RequestParam int shopID){
        return productDetailService.getProductDetailByShopID(shopID);
    }
    @RequestMapping(value = "api/best_app/product_detail/byShopID_ProductID", method = RequestMethod.GET)
    public List<ProductDetail> getProductDetailByShopIDAndProductID(@RequestParam int shopID, @RequestParam int productID){
        return productDetailService.getProductDetailByShopIDAndProductID(shopID, productID);
    }
    @RequestMapping(value = "api/best_app/product_detail/byProductID_ColorID_SizeID", method = RequestMethod.GET)
    public ProductDetail getProductDetailByProductIdAndColorIdAndSizeID(@RequestParam int productID, @RequestParam int colorID, @RequestParam int sizeID){
        return productDetailService.getProductDetailByProductIdAndColorIdAndSizeID(productID, colorID, sizeID);
    }
    @RequestMapping(value = "api/best_app/product_detail/byColorID", method = RequestMethod.GET)
    public int getSumProductByColorId(@RequestParam int id){
        return productDetailService.getSumProductByColorID(id);
    }

    @RequestMapping(value = "api/best_app/product_detail/bySizeID", method = RequestMethod.GET)
    public int getSumProductBySizeId(@RequestParam int id){
        return productDetailService.getSumProductBySizeID(id);
    }

    @RequestMapping(value = "api/best_app/product_detail/byColorId_SizeId", method = RequestMethod.GET)
    public int getSumProductByColorIdAndSizeID(@RequestParam int colorID, @RequestParam int sizeID){
        return productDetailService.getSumProductByColorIdAndSizeId(colorID, sizeID);
    }

    @RequestMapping(value = "api/best_app/product_detail/create", method = RequestMethod.POST)
    public boolean addProductDetail(@RequestBody ProductDetailDto ob) {
        return productDetailService.addProductDetail(ob);}
    @RequestMapping(value = "api/best_app/product_detail/update", method = RequestMethod.PUT)
    public boolean updateProductDetail(@RequestBody ProductDetailDto ob) {
        return productDetailService.updateProductDetail(ob);}
    @RequestMapping(value = "api/best_app/product_detail/delete", method = RequestMethod.DELETE)
    public boolean removeProductDetail(@RequestParam int id){
        return productDetailService.removeProductDetail(id);
    }
}
