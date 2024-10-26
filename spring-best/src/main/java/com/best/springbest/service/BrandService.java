package com.best.springbest.service;

import com.best.springbest.model.Brand;
import com.best.springbest.repository.BrandRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
@Service
public class BrandService {
    @Autowired
    BrandRepository obRepository;

    public List<Brand> getAllBrand(){
        try{
            return obRepository.findAll();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public  Brand getBrandByID(int id){
        try{
            return obRepository.findBrandsByID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public boolean addBrand(Brand ob){
        try{
            obRepository.save(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean updateBrand(Brand ob){
        try{
            obRepository.save(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean removeBrand(int id){
        try{
            Brand ob = obRepository.findBrandsByID(id);
            obRepository.delete(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }
}
