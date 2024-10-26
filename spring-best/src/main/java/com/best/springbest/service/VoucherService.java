package com.best.springbest.service;

import com.best.springbest.dto.VoucherDto;
import com.best.springbest.model.*;
import com.best.springbest.repository.ProductRepository;
import com.best.springbest.repository.ShopRepository;
import com.best.springbest.repository.VoucherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class VoucherService {
    @Autowired
    VoucherRepository obRepository;
    @Autowired
    ShopRepository shopRepository;
    @Autowired
    ProductRepository productRepository;

    public List<Voucher> getAllVoucher(){
        try{
            return obRepository.findAll();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public Voucher getVoucherByID(int id){
        try{
            return obRepository.findVouchersByID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public List<Voucher> getVoucherByShopID(int id){
        try{
            return obRepository.findVouchersShopID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }

    public boolean addVoucher(VoucherDto ob){
        try{
            Shop shop = shopRepository.findShopByID(ob.getShop_id());
            Product product = productRepository.findProductsByID(ob.getProduct_id());
            obRepository.save(new Voucher(0,ob.getCode(),shop,product, ob.getDate_start(),ob.getDate_end(), ob.getDiscount_percent(), ob.getDescription()));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean updateVoucher(VoucherDto ob){
        try{
            Shop shop = shopRepository.findShopByID(ob.getShop_id());
            Product product = productRepository.findProductsByID(ob.getProduct_id());
            obRepository.save(new Voucher(ob.getId(),ob.getCode(),shop,product, ob.getDate_start(),ob.getDate_end(), ob.getDiscount_percent(), ob.getDescription()));
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }

    public boolean removeVoucher(int id){
        try{
            Voucher ob = obRepository.findVouchersByID(id);
            obRepository.delete(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }
}
