package com.best.springbest.service;

import com.best.springbest.dto.ProductSizeDto;
import com.best.springbest.model.Product;
import com.best.springbest.model.ProductSize;
import com.best.springbest.model.Size;
import com.best.springbest.repository.ProductRepository;
import com.best.springbest.repository.ProductSizeRepository;
import com.best.springbest.repository.SizeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ProductSizeService {
    @Autowired
    ProductSizeRepository obRepository;
    @Autowired
    ProductRepository pRepository;
    @Autowired
    SizeRepository sRepository;
    public List<ProductSize> getAllProductSize(){
        try{
            return obRepository.findAll();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public ProductSize getProductSizeByID(int id){
        try{
            return obRepository.findProductSizeByID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public  List<ProductSize> getProductSizeByProductID(int id){
        try{
            return obRepository.findProductSizeByProductID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public  List<ProductSize> getProductSizeByProductIdAndSizeID(int productID, int sizeID){
        try{
            return obRepository.findProductSizeByProductIdAndSizeID(productID, sizeID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public boolean addProductSize(ProductSizeDto productSizeDto){
        try{
            Product product = pRepository.findProductsByID(productSizeDto.getProduct_id());
            Size size = sRepository.findSizeByID(productSizeDto.getSize_id());
            obRepository.save(new ProductSize(0,product,size));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean updateProductSize(ProductSizeDto productSizeDto){
        try{
            Product product = pRepository.findProductsByID(productSizeDto.getProduct_id());
            Size size = sRepository.findSizeByID(productSizeDto.getSize_id());
            obRepository.save(new ProductSize(productSizeDto.getId(),product,size));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean removeProductSize(int id){
        try{
            ProductSize ob = obRepository.findProductSizeByID(id);
            obRepository.delete(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }
}
