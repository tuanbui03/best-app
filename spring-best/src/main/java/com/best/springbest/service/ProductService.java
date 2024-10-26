package com.best.springbest.service;

import com.best.springbest.dto.ProductDto;
import com.best.springbest.handle.DateHanle;
import com.best.springbest.model.Brand;
import com.best.springbest.model.Category;
import com.best.springbest.model.Product;
import com.best.springbest.model.Shop;
import com.best.springbest.repository.BrandRepository;
import com.best.springbest.repository.CategoryRepository;
import com.best.springbest.repository.ProductRepository;
import com.best.springbest.repository.ShopRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ProductService {
    @Autowired
    ProductRepository obRepository;
    @Autowired
    BrandRepository bRepository;
    @Autowired
    CategoryRepository cRepository;
    @Autowired
    ShopRepository shopRepository;
    public List<Product> getAllProduct(){
        try{
            return obRepository.findAll();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public List<Product> getAllProductAction(){
        try{
            return obRepository.findAllProductAction();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public Product getProductByID(int id){
        try{
            return obRepository.findProductsByID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public List<Product> searchProductByName(String str){
        try{
            return obRepository.findProductsByNameContaining(str);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public List<Product> findProductByCategoryID(int id){
        try{
            return obRepository.findProductsByCategoryID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public List<Product> findProductByBrandID(int id){
        try{
            return obRepository.findProductsByBrandBrandID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public List<Product> findProductRemain(int shopID, int productID){
        try{
            return obRepository.findProductRemaining(shopID, productID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public List<Product> findProductByShopID(int id){
        try{
            return obRepository.findProductsByShopID(id);
        }catch (Exception e){
        System.out.print(e.getMessage());
        }
        return null;
}
    public boolean addProduct(ProductDto ob){
        try{
            Brand brand = bRepository.findBrandsByID(ob.getBrand_id());
            Category category = cRepository.findCategoriesByID(ob.getCategory_id());
            Shop shop = shopRepository.findShopByID(ob.getShop_id());
            obRepository.save(new Product(0,brand,category,shop,ob.getName(),ob.getQuantity(),ob.getPrice(),ob.getDescription(),ob.getCode(),ob.getDiscount(),0, DateHanle.getDateNow(),ob.getStatus()));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean updateProduct(ProductDto ob){
        try{
            Brand brand = bRepository.findBrandsByID(ob.getBrand_id());
            Category category = cRepository.findCategoriesByID(ob.getCategory_id());
            Shop shop = shopRepository.findShopByID(ob.getShop_id());
            Product product = obRepository.findProductsByID(ob.getId());
            obRepository.save(new Product(ob.getId(),brand,category,shop,ob.getName(),ob.getQuantity(),ob.getPrice(),ob.getDescription(),ob.getCode(),ob.getDiscount(),ob.getSold(),product.getCreated_at(),ob.getStatus()));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean removeProduct(int id){
        try{
            Product ob = obRepository.findProductsByID(id);
            obRepository.delete(ob);
            return true;
        }catch (Exception e){
        System.out.print(e.getMessage());
        }
        return false;
    }

    //Sort
    public List<Product> getProductName(){
        try{
            return obRepository.findAll(Sort.by(Sort.Direction.ASC, "name"));
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public List<Product> getProductHeightPrice(){
        try{
            return obRepository.findAll(Sort.by(Sort.Direction.DESC, "price"));
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public List<Product> getProductLowPrice(){
        try{
            return obRepository.findAll(Sort.by(Sort.Direction.ASC, "price"));
        }catch (Exception e){
        System.out.print(e.getMessage());
        }
        return null;
    }

    public List<Product> getProductSale(){
        try{
            return obRepository.findProductsSale();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public List<Product> getProductNew(){
        try{
            return obRepository.findAll(Sort.by(Sort.Direction.ASC, "id"));
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public List<Product> getProductPopular(){
        try{
            return obRepository.findAll(Sort.by(Sort.Direction.DESC, "sold"));
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
}
