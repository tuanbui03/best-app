package com.best.springbest.service;
import com.best.springbest.dto.ProductColorDto;
import com.best.springbest.model.Color;
import com.best.springbest.model.Product;
import com.best.springbest.model.ProductColor;
import com.best.springbest.repository.ColorRepository;
import com.best.springbest.repository.ProductColorRepository;
import com.best.springbest.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ProductColorService {
    @Autowired
    ProductColorRepository obRepository;
    @Autowired
    ProductRepository pRepository;
    @Autowired
    ColorRepository cRepository;
    public List<ProductColor> getAllProductColor  (){
        try{
            return obRepository.findAll();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public ProductColor getProductColorByID(int id){
        try{
            return obRepository.findProductColorByID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public List<ProductColor> getListImageByProductID(int id){
        try{
            return obRepository.findProductColorByProductID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public List<ProductColor> getProductColorByProductIdAndColorID(int productID, int colorId){
        try{
            return obRepository.findProductColorByProductIdAndColorID(productID, colorId);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public boolean addProductColor(ProductColorDto ob){
        try{
            Product product = pRepository.findProductsByID(ob.getProduct_id());
            Color color = cRepository.findColorByID(ob.getColor_id());
            obRepository.save(new ProductColor(0, product,color,ob.getImage()));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean updateProductColor(ProductColorDto ob){
        try{
            Product product = pRepository.findProductsByID(ob.getProduct_id());
            Color color = cRepository.findColorByID(ob.getColor_id());
            obRepository.save(new ProductColor(ob.getId(), product,color,ob.getImage()));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean removeProductColor(int id){
        try{
            ProductColor ob = obRepository.findProductColorByID(id);
            obRepository.delete(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }
}
