package com.best.springbest.service;

import com.best.springbest.model.Shop;
import com.best.springbest.repository.ShopRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
@Service
public class ShopService {
    @Autowired
    ShopRepository obRepository;

    public List<Shop> getAllShop(){
        try{
            return obRepository.findAll();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public  Shop getShopByID(int id){
        try{
            return obRepository.findShopByID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public  List<Shop> getShopBySearchName(String name){
        try{
            return obRepository.findShopsByNameContaining(name);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public boolean addShop(Shop ob){
        try{
            obRepository.save(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean updateShop(Shop ob){
        try{
            obRepository.save(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean removeShop(int id){
        try{
            Shop ob = obRepository.findShopByID(id);
            obRepository.delete(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }
}
