package com.best.springbest.service;

import com.best.springbest.dto.ProductDetailDto;
import com.best.springbest.model.ProductColor;
import com.best.springbest.model.ProductDetail;
import com.best.springbest.model.ProductSize;
import com.best.springbest.repository.ProductColorRepository;
import com.best.springbest.repository.ProductDetailRepository;
import com.best.springbest.repository.ProductSizeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ProductDetailService {
    @Autowired
    ProductDetailRepository obRepository;
    @Autowired
    ProductSizeRepository psRepository;
    @Autowired
    ProductColorRepository pcRepository;
    public List<ProductDetail> getAllProductDetail(){
        try{
            return obRepository.findAll();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public ProductDetail getProductDetailByID(int id){
        try{
            return obRepository.findProductDetailByID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public List<ProductDetail> getProductDetailByShopID(int shopID){
        try{
            return obRepository.findProductDetailByShopID(shopID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public List<ProductDetail> getProductDetailByShopIDAndProductID(int shopID, int productID){
        try{
            return obRepository.findProductDetailByShopIDAndProductID(shopID, productID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public ProductDetail getProductDetailByProductIdAndColorIdAndSizeID(int productID ,int colorID, int sizeID){
        try{
            return obRepository.findProductDetailByProductIdAndColorIdAndSizeID(productID, colorID, sizeID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public int getSumProductByColorID(int id){
        try{
            return obRepository.sumProductByColorID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return 0;
    }

    public int getSumProductBySizeID(int id){
        try{
            return obRepository.sumProductBySizeID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return 0;
    }

    public int getSumProductByColorIdAndSizeId(int colorID, int sizeID){
        try{
            return obRepository.sumProductByColorIdAndSizeId(colorID, sizeID);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return 0;
    }

    public boolean addProductDetail(ProductDetailDto ob){
        try{
            ProductSize productSize = psRepository.findProductSizeByID(ob.getProduct_size_id());
            ProductColor productColor = pcRepository.findProductColorByID(ob.getProduct_color_id());
            obRepository.save(new ProductDetail(0,productSize,productColor,ob.getQuantity()));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean updateProductDetail(ProductDetailDto ob){
        try{
            ProductSize productSize = psRepository.findProductSizeByID(ob.getProduct_size_id());
            ProductColor productColor = pcRepository.findProductColorByID(ob.getProduct_color_id());
            obRepository.save(new ProductDetail(ob.getId(),productSize,productColor,ob.getQuantity()));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean removeProductDetail(int id){
        try{
            ProductDetail ob = obRepository.findProductDetailByID(id);
            obRepository.delete(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }
}
